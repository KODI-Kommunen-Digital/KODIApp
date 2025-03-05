// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/list_cubit.dart';
import 'package:heidi/src/presentation/widget/custom_webview.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'cubit/cubit.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  int? selectedLocationId;
  ProductFilter? selectedFilter;

  @override
  void initState() {
    super.initState();
    loadLocationList();
  }

  Future<void> loadLocationList() async {
    await context.read<DiscoveryCubit>().onLoad(1);
  }

  Future<void> loadSelectedLocation() async {
    final cityId = await context.read<DiscoveryCubit>().getCitySelected();
    setState(() {
      selectedLocationId = cityId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('cust_services')),
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

  const DiscoveryLoaded({
    super.key,
    required this.services,
  });

  @override
  State<DiscoveryLoaded> createState() => _DiscoveryLoadedState();
}

class _DiscoveryLoadedState extends State<DiscoveryLoaded> {
  bool isLoading = false;
  final _scrollController = ScrollController();
  List<CitizenServiceModel> services = [];

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
    // if (service.imageLink == "1") {
    //   await launchUrl(Uri.parse('https://mitreden.ilzerland.bayern/ringelai'),
    //       mode: LaunchMode.inAppWebView);
    // } else if (service.imageLink == "2") {
    //   await launchUrl(
    //       Uri.parse(await AppBloc.discoveryCubit.getCityLink() ?? ""),
    //       mode: LaunchMode.inAppWebView);
    // } else if (service.imageLink == "10") {
    //   final cityId = await context.read<DiscoveryCubit>().getCitySelected();
    //   if (cityId != 0) {
    //     if (!mounted) return;
    //     Navigator.pushNamed(context, Routes.listGroups,
    //         arguments: {'id': service.arguments, 'title': 'forums'});
    //   } else {
    //     if (!mounted) return;
    //     _showCitySelectionPopup(context);
    //   }
    // }

    // void showAbfallPopup(BuildContext context) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text(Translate.of(context).translate('waste_calendar')),
    //         content: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Text(Translate.of(context).translate('waste_calendar_message')),
    //             const SizedBox(height: 12),
    //           ],
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    // Future<bool> showContestRules(BuildContext context) async {
    //   bool shouldLaunch = false;

    //   await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text("Gewinnspiel"),
    //         content: const Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Text(
    //                 "Regeln: Trage deine Email Adresse ein und habe die Chance auf einen Gewinn. "),
    //             SizedBox(height: 12),
    //             Text(
    //                 "Hinweis: Apple steht in keiner Verbindung zum Gewinnspiel."),
    //           ],
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               shouldLaunch = true;
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );

    //   return shouldLaunch;
    // }

    Future<void> launchContestPage(
        BuildContext context, String imageLink) async {
      // Show the contest rules dialog
      // bool shouldLaunch = await showContestRules(context);

      // If the user clicks OK, launch the URL
      // if (shouldLaunch) {
      String? serviceLink =
          await AppBloc.discoveryCubit.getServiceLink(imageLink);
      if (serviceLink != null && serviceLink.isNotEmpty) {
        await launchUrl(
          Uri.parse(serviceLink),
          mode: LaunchMode.inAppWebView,
        );
        // }
      }
    }

    if (service.imageLink == "3" ||
        service.imageLink == "4" ||
        service.imageLink == "5" ||
        service.imageLink == "8" ||
        service.imageLink == "9" ||
        service.imageLink == "12" ||
        service.imageLink == "13" ||
        service.imageLink == "14" ||
        service.imageLink == "15") {
      final url =
          await AppBloc.discoveryCubit.getServiceLink(service.imageLink);

      if (url != null && url.isNotEmpty) {
        CustomWebViewScreen.showAsBottomSheet(context: context, url: url);
      }

      if (service.imageLink == "4" ||
          service.imageLink == "9" ||
          service.imageLink == "13") {
        Routes.trackMatomoEvent(true, null, int.parse(service.imageLink), null);
      } else {
        Routes.trackMatomoEvent(
            false, null, int.parse(service.imageLink), null);
      }
    } else if (service.imageLink == "11" || service.imageLink == "7") {
      Routes.trackMatomoEvent(false, null, int.parse(service.imageLink), null);
      await launchContestPage(context, service.imageLink);
    } else if (service.imageLink == "6") {
      await Navigator.pushNamed(context, Routes.discoveryDetail, arguments: {
        'id': 6,
      });
    }
// else if (service.imageLink == "8") {
//   _onSubmit();
// }
    else if (service.imageLink == "10") {
      Routes.trackMatomoEvent(false, null, int.parse(service.imageLink), null);
      Navigator.pushNamed(context, Routes.wasteCalendar);
    } else if (service.imageLink == "16") {
      Navigator.pushNamed(context, Routes.trolleyMakerSignIn);
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

// void _onSubmit() async {
//   if (AppBloc.userCubit.state == null) {
//     final result = await Navigator.pushNamed(
//       context,
//       Routes.signIn,
//       arguments: Routes.submit,
//     );
//     if (result == null) return;
//   }
//   if (!mounted) return;
//   Navigator.pushNamed(context, Routes.submit, arguments: {'isNewList': true});
// }
}
