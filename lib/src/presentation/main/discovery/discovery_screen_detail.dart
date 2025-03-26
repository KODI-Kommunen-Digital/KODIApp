// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/custom_webview.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/mobilitat_helper.dart';
import 'package:heidi/src/utils/translate.dart';
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

  @override
  void initState() {
    super.initState();
    discoveryCubit = DiscoveryCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadLocationList();
    });
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
          title: Text((widget.arguments['id'] == 16)
              ? "TroCARD"
              : Translate.of(context).translate('cust_services')),
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
      MobilitatHelper.showMobilitat(context);
    } else if (service.arguments == 62) {
      Routes.trackMatomoEvent(false, null, 62, null);

      CustomWebViewScreen.showAsBottomSheet(
        context: context,
        url:
            "https://troisdorf.dksr.city/public-dashboards/f4dd7e02258d4a13a610ea463946f510?orgId=1",
        title: 'Parken',
      );
    } else if (service.arguments == 161) {
      Navigator.pushNamed(context, Routes.trolleyMakerMyCredit);
    } else if (service.arguments == 162) {
      Navigator.pushNamed(context, Routes.trolleyMakerCards);
    } else if (service.arguments == 163) {
      Navigator.pushNamed(context, Routes.trolleyMakerPartner);
    } else if (service.arguments == 164) {
      Navigator.pushNamed(context, Routes.trolleyNewsScreen);
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
}
