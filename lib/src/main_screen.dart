import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/cubit/authentication/cubit.dart';
import 'package:heidi/src/presentation/main/account/account_profile/account_screen.dart';
import 'package:heidi/src/presentation/main/account/change_password/change_password_screen.dart';
import 'package:heidi/src/presentation/main/discovery/discovery_screen.dart';
import 'package:heidi/src/presentation/main/home/home_screen/home.dart';
import 'package:heidi/src/presentation/main/wishlist/wishlist_screen.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:uni_links/uni_links.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  String _selectedPage = Routes.home;
  late bool login;
  bool loadLink = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      String? initialLink = await getInitialLink();
      if (initialLink != null) {
        setState(() {
          loadLink = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const submitPosition = FloatingActionButtonLocation.centerDocked;
    return (loadLink)
        ? FutureBuilder(
            future: getInitialLink(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                loadLink = false;
                if (snapshot.data != null) {
                  if (snapshot.data!.contains(
                      "https://app.smartregion-auf.de/VerifyEmail?")) {
                    //return VerifyEmail page
                  } else if (snapshot.data!.contains(
                      "https://app.smartregion-auf.de/PasswordForgot?")) {
                    return const ChangePasswordScreen();
                  }
                }
                return Scaffold(
                  body: BlocListener<AuthenticationCubit, AuthenticationState>(
                    listener: (context, authentication) async {
                      _listenAuthenticateChange(authentication);
                    },
                    child: IndexedStack(
                      index: _exportIndexed(_selectedPage),
                      children: const <Widget>[
                        HomeScreen(),
                        DiscoveryScreen(),
                        WishListScreen(),
                        AccountScreen()
                      ],
                    ),
                  ),
                  bottomNavigationBar: _buildBottomMenu(),
                  floatingActionButton: _buildSubmit(),
                  floatingActionButtonLocation: submitPosition,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            })
        : Scaffold(
            body: BlocListener<AuthenticationCubit, AuthenticationState>(
              listener: (context, authentication) async {
                _listenAuthenticateChange(authentication);
              },
              child: IndexedStack(
                index: _exportIndexed(_selectedPage),
                children: const <Widget>[
                  HomeScreen(),
                  DiscoveryScreen(),
                  WishListScreen(),
                  AccountScreen()
                ],
              ),
            ),
            bottomNavigationBar: _buildBottomMenu(),
            floatingActionButton: _buildSubmit(),
            floatingActionButtonLocation: submitPosition,
          );
  }

  bool _requireAuth(String route) {
    switch (route) {
      case Routes.home:
      case Routes.discovery:
        return false;
      default:
        return true;
    }
  }

  int _exportIndexed(String route) {
    switch (route) {
      case Routes.home:
        return 0;
      case Routes.discovery:
        return 1;
      case Routes.wishList:
        return 2;
      case Routes.account:
        return 3;
      default:
        return 0;
    }
  }

  void _listenAuthenticateChange(AuthenticationState authentication) async {
    if (authentication == const AuthenticationState.failed() &&
        _requireAuth(_selectedPage)) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: _selectedPage,
      ).then((value) {
        setState(() {});
      });
      if (result != null) {
        setState(() {
          _selectedPage = result as String;
        });
      } else {
        setState(() {
          _selectedPage = Routes.home;
        });
      }
    }
  }

  void _onItemTapped(String route) async {
    if (AppBloc.userCubit.state == null && _requireAuth(route)) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: route,
      );
      if (result == null) return;
    }
    setState(() {
      _selectedPage = route;
    });

    switch (route) {
      case Routes.home:
        AppBloc.homeCubit.setDoesScroll(true);
        AppBloc.homeCubit.scrollUp();
        break;

      case Routes.wishList:
        AppBloc.wishListCubit.setDoesScroll(true);
        AppBloc.wishListCubit.scrollUp();
        break;
      case Routes.discovery:
        AppBloc.discoveryCubit.setDoesScroll(true);
        AppBloc.discoveryCubit.scrollUp();
        break;
    }
  }

  Widget _buildMenuItem(String route) {
    Color? color;
    String title = Translate.of(context).translate(
      'home',
    );
    IconData iconData = Icons.help_outline;
    switch (route) {
      case Routes.home:
        iconData = Icons.home_outlined;
        title = Translate.of(context).translate(
          'home',
        );
        break;
      case Routes.discovery:
        iconData = Icons.touch_app_rounded;
        title = Translate.of(context).translate(
          'services',
        );
        break;
      case Routes.wishList:
        iconData = Icons.bookmark_outline;
        title = Translate.of(context).translate(
          'wish_list',
        );
        break;
      case Routes.account:
        iconData = Icons.account_circle_outlined;
        title = Translate.of(context).translate(
          'maccount',
        );
        break;
      default:
        iconData = Icons.home_outlined;
        title = 'home';
        break;
    }
    if (route == _selectedPage) {
      color = Theme.of(context).primaryColor;
    }
    return IconButton(
      onPressed: () {
        _onItemTapped(route);
      },
      padding: EdgeInsets.zero,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: color,
          ),
          const SizedBox(height: 2),
          Text(
            Translate.of(context).translate(title),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 10,
                  color: color,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget? _buildSubmit() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: _onSubmit,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _onSubmit() async {
    if (AppBloc.userCubit.state == null) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: Routes.submit,
      );
      if (result == null) return;
    }
    if (!mounted) return;
    Navigator.pushNamed(context, Routes.submit, arguments: {'isNewList': true});
  }

  Widget _buildBottomMenu() {
    return BottomAppBar(
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuItem(Routes.home),
            _buildMenuItem(Routes.discovery),
            const SizedBox(width: 56),
            _buildMenuItem(Routes.wishList),
            _buildMenuItem(Routes.account),
          ],
        ),
      ),
    );
  }
}
