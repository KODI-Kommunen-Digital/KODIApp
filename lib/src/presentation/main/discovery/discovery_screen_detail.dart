// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/custom_webview.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/mobilitat_helper.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/trolley_maker_session.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'cubit/cubit.dart';

class DiscoveryScreenDetail extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const DiscoveryScreenDetail({super.key, required this.arguments});

  @override
  State<DiscoveryScreenDetail> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreenDetail> {
  int? selectedLocationId;

  late DiscoveryCubit discoveryCubit;

  bool _isTrolleyMakerSignedIn = false;

  bool get _isTrolleyMaker => widget.arguments['id'] == 16;

  @override
  void initState() {
    super.initState();
    discoveryCubit = DiscoveryCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadLocationList();
    });
    if (_isTrolleyMaker) {
      _refreshTrolleyMakerSession();
    }
  }

  Future<void> _refreshTrolleyMakerSession() async {
    if (!mounted || !_isTrolleyMaker) return;
    final signedIn = await context
        .read<TrolleyMakerRepository>()
        .hasValidTrolleyMakerAuthToken();
    if (!mounted) return;
    setState(() {
      _isTrolleyMakerSignedIn = signedIn;
    });
  }

  Future<void> _confirmTrolleyMakerLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(Translate.of(dialogContext).translate('sign_out')),
          content: Text(Translate.of(dialogContext)
              .translate('trolley_maker_logout_confirm')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(Translate.of(dialogContext).translate('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(Translate.of(dialogContext).translate('sign_out')),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) return;
    await TrolleyMakerSession.clear(context);
    if (!mounted) return;
    setState(() {
      _isTrolleyMakerSignedIn = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context)
            .translate('trolley_maker_logout_success'))));
  }

  Future<void> loadLocationList() async {
    await discoveryCubit.onLoad(widget.arguments['id']);
  }

  Future<void> loadSelectedLocation() async {
    final cityId = await discoveryCubit.getCitySelected();
    setState(() {
      selectedLocationId = cityId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => discoveryCubit, // Override with a new local instance
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            (widget.arguments['id'] == 16)
                ? "StadtGUTSCHEIN"
                : (widget.arguments['id'] == 6
                ? Translate.of(context).translate('mobility')
                : Translate.of(context).translate('cust_services')),
          ),
          actions: [
            if (_isTrolleyMaker && _isTrolleyMakerSignedIn)
              TextButton(
                onPressed: _confirmTrolleyMakerLogout,
                child: Text(Translate.of(context).translate('sign_out'),
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),),
              ),
          ],
        ),
        body: BlocConsumer<DiscoveryCubit, DiscoveryState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (msg) => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg))),
              orElse: () {},
            );
          },
          builder: (context, state) => state.when(
            loading: () {
              return const DiscoveryLoading();
            },
            loaded: (list) => DiscoveryLoaded(
              services: list,
              onTrolleyMakerSessionChanged: _refreshTrolleyMakerSession,
            ),
            updated: (list) {
              return Container();
            },
            error: (e) => ErrorWidget('Failed to load listings.'),
            initial: () {
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class DiscoveryLoading extends StatelessWidget {
  const DiscoveryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class DiscoveryLoaded extends StatefulWidget {
  final List<CitizenServiceModel> services;
  final VoidCallback? onTrolleyMakerSessionChanged;

  const DiscoveryLoaded({
    super.key,
    required this.services,
    this.onTrolleyMakerSessionChanged,
  });

  @override
  State<DiscoveryLoaded> createState() => _DiscoveryLoadedState();
}

class _DiscoveryLoadedState extends State<DiscoveryLoaded> {
  bool isLoading = false;
  final _scrollController = ScrollController();
  List<CitizenServiceModel> services = [];
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    super.initState();
    services = widget.services;
  }

  void scrollUp() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }

  @override
  Widget build(BuildContext context) {
    if (AppBloc.discoveryCubit.getDoesScroll()) {
      AppBloc.discoveryCubit.setDoesScroll(false);
      scrollUp();
    }
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust the number of columns as desired
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent: 300.0),
        itemCount: services.length,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              navigateToLink(services[index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                services[index].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> navigateToLink(CitizenServiceModel service) async {
    if (service.arguments == 61) {
      Routes.trackMatomoEvent(true, null, 5, null);
      CustomWebViewScreen.showAsBottomSheet(
          context: context,
          url: "https://map.troisdorf.civora.org/",
          title: 'Mobilitätskarte',
          needGeoLocation: true);
    } else if (service.arguments == 62) {
      Routes.trackMatomoEvent(false, null, 62, null);

      CustomWebViewScreen.showAsBottomSheet(
        context: context,
        url:
            "https://superset.troisdorf.civora.org/superset/dashboard/p/M2op2NDpleg/?standalone=3",
        title: 'Parken',
      );
    } else if (service.arguments == 161) {
      await _openTrolleyMakerCard(Routes.trolleyMakerMyCredit,
          requiresLogin: true);
    } else if (service.arguments == 162) {
      await _openTrolleyMakerCard(Routes.trolleyMakerCards,
          requiresLogin: true);
    } else if (service.arguments == 163) {
      // Partner APIs are public, no sign-in needed.
      await _openTrolleyMakerCard(Routes.trolleyMakerPartner,
          requiresLogin: false);
    } else if (service.arguments == 164) {
      // News APIs are public, no sign-in needed.
      await _openTrolleyMakerCard(Routes.trolleyNewsScreen,
          requiresLogin: false);
    } else {
      AppBloc.discoveryCubit
          .setServiceValue(Preferences.type, service.type, null);
      if (service.categoryId != null) {
        AppBloc.discoveryCubit
            .setServiceValue(Preferences.categoryId, null, service.categoryId);
      }
      Navigator.pushNamed(context, Routes.listProduct, arguments: {
        'id': service.arguments,
        'title': '',
        'type': 'categoryService'
      });
    }
  }

  Future<void> _openTrolleyMakerCard(String route,
      {required bool requiresLogin}) async {
    if (requiresLogin) {
      final signedIn = await context
          .read<TrolleyMakerRepository>()
          .hasValidTrolleyMakerAuthToken();
      if (!mounted) return;
      if (!signedIn) {
        final loggedIn = await _requestTrolleyMakerSignIn();
        if (!mounted) return;
        widget.onTrolleyMakerSessionChanged?.call();
        if (!loggedIn) return;
      }
    }
    await Navigator.pushNamed(context, route);
    // The session may have expired while the card was open.
    if (!mounted) return;
    widget.onTrolleyMakerSessionChanged?.call();
  }

  /// Shows the login required popup and opens the Trolley Maker sign-in.
  /// Returns true when the user signed in successfully.
  Future<bool> _requestTrolleyMakerSignIn() async {
    final wantsSignIn = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(Translate.of(dialogContext).translate('login_required')),
          content: Text(Translate.of(dialogContext)
              .translate('trolley_maker_login_required_message')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(Translate.of(dialogContext).translate('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(Translate.of(dialogContext).translate('sign_in')),
            ),
          ],
        );
      },
    );
    if (wantsSignIn != true || !mounted) return false;
    final result =
        await Navigator.pushNamed(context, Routes.trolleyMakerSignIn);
    return result == true;
  }
}
