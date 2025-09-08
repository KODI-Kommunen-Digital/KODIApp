import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/list_cubit.dart';
import 'package:heidi/src/presentation/main/home/widget/app_filter_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/custom_webview.dart';
import 'package:heidi/src/presentation/main/discovery/sub_discovery_screen.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/configs/image.dart';
import '../../../utils/configs/routes.dart';
import 'cubit/cubit.dart';

class DiscoveryScreen extends StatefulWidget {
  final DiscoveryType type;

  const DiscoveryScreen({super.key, required this.type});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

enum DiscoveryType { explore, services }

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  int? selectedLocationId;
  ProductFilter? selectedFilter;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadLocationList();
  }

  Future<void> loadLocationList() async {
    await context.read<DiscoveryCubit>().onLoad();
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
        title: Text(Translate.of(context).translate(
            (widget.type == DiscoveryType.services)
                ? 'cust_services'
                : 'discover')),
        // actions: [
        //   BlocConsumer<DiscoveryCubit, DiscoveryState>(
        //     listener: (context, state) {},
        //     builder: (context, state) => state.maybeWhen(
        //         loaded: (services, explore) => Row(
        //           children: [
        //             AppFilterButton(
        //               multiFilter: MultiFilter(
        //                 hasLocationFilter: true,
        //                 currentLocation:
        //                 context.read<DiscoveryCubit>().currentCity ?? 0,
        //                 cities: context.read<DiscoveryCubit>().location,
        //               ),
        //               filterCallBack: (filter) async {
        //                 if (filter.currentLocation != null) {
        //                   context
        //                       .read<DiscoveryCubit>()
        //                       .onLocationFilter(filter.currentLocation!, true);
        //                 }
        //               },
        //             ),
        //             IconButton(
        //                 onPressed: () {
        //                   _searchServices();
        //                 },
        //                 icon: Icon(
        //                   Icons.search,
        //                   color:
        //                   Theme.of(context).textTheme.bodyLarge?.color ??
        //                       Colors.white,
        //                 ))
        //           ],
        //         ),
        //         orElse: () => Container()),
        //   )
        // ],
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
          loaded: (services, explore) => DiscoveryLoaded(
            services: services,
            explore: explore,
            type: widget.type,
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

  Future _searchServices() async {
    String? searchResult = await openSearchDialog();
    if (searchResult is String && searchResult.trim() != "") {
      context.read<DiscoveryCubit>().searchServices(searchResult.trim(), widget.type);
    } else if ((searchResult == null || searchResult.trim() == "") &&
        context.read<DiscoveryCubit>().isSearching) {
      context.read<DiscoveryCubit>().cancelSearch(widget.type);
    }
  }

  Future<String?> openSearchDialog() async {
    String? searchRequest = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            if (didPop) return;
            Navigator.pop(context, context.read<DiscoveryCubit>().searchTerm);
          },
          child: SimpleDialog(
              title: Center(
                  child: Text(Translate.of(context).translate('search_title'))),
              contentPadding: const EdgeInsets.all(24.0),
              children: [
                AppTextInput(
                  hintText: Translate.of(context).translate('search_title'),
                  keyboardType: TextInputType.text,
                  controller: _searchController,
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _searchController.clear();
                        Navigator.pop(context, null);
                      },
                      child: Text(Translate.of(context).translate('cancel')),
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () {
                        String content = _searchController.text;
                        Navigator.pop(context, content);
                      },
                      child: Text(
                        Translate.of(context).translate('search_title'),
                      ),
                    ),
                  ],
                ),
              ]),
        );
      },
    );
    return searchRequest;
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
  final List<CitizenServiceModel> explore;
  final DiscoveryType type;
  final bool isSearching;
  final String searchTerm;

  const DiscoveryLoaded(
      {
        super.key,
        required this.services,
        required this.explore,
        required this.type,
        this.isSearching = false,
        this.searchTerm = '',
      });

  @override
  State<DiscoveryLoaded> createState() => _DiscoveryLoadedState();
}

class _DiscoveryLoadedState extends State<DiscoveryLoaded> {
  bool isLoading = false;
  final _scrollController = ScrollController();
  List<CitizenServiceModel> services = [];
  List<CitizenServiceModel> explore = [];

  @override
  void initState() {
    super.initState();
    services = widget.services;
    explore = widget.explore;
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

    final currentList = widget.type == DiscoveryType.services
        ? widget.services
        : widget.explore;

    if (currentList.isEmpty) {
      return Center(
        child: Text(
          Translate.of(context).translate('no_services_available'),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        child:GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: 300.0,
          ),
        itemCount: currentList.length,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
          final item = currentList[index];
            return InkWell(
              onTap: () {
                navigateToLink(item);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Stack(
                  children: [
                  Image.asset(
                      item.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  if (widget.isSearching &&
                      item.title.toLowerCase().contains(widget.searchTerm.toLowerCase()))
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Match',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Image.asset(Theme.of(context).brightness == Brightness.dark ? Images.logoDark:Images.logo,),
    );
  }

  Future<void> navigateToLink(CitizenServiceModel service) async {
    switch (service.imageLink) {
      case "17":
        CustomWebViewScreen.showAsBottomSheet(
            context: context,
            title: service.title,
            url:
                'https://cockpit.gera.de/d/KsIwvw5nz/cockpit?orgId=1&refresh=15m');
        break;
      case "18":
        CustomWebViewScreen.showAsBottomSheet(
            context: context,
            title: service.title,
            url: 'https://geoportal.gera.de/portalserver/#/portal/gera');
        break;
      case "19":
        CustomWebViewScreen.showAsBottomSheet(
            context: context,
            title: service.title,
            url: 'https://app.spotar.de/gera');
        break;
      case "20":
        CustomWebViewScreen.showAsBottomSheet(
            context: context,
            title: service.title,
            url: 'https://www.gvbgera.de/fahrplaene/gvb-liniennetz');
        break;
      case "21":
        CustomWebViewScreen.showAsBottomSheet(
            context: context,
            title: service.title,
            url: 'https://www.gvbgera.de/tickets/fahrscheine');
        break;
      case "22":
        break;
      case "23":
        CustomWebViewScreen.showAsBottomSheet(
            context: context,
            title: service.title,
            url: 'https://www.gera.de/serviceportal');
        break;
      case "24":
        CustomWebViewScreen.showAsBottomSheet(
            context: context,
            title: service.title,
            url: 'https://www.awv-ot.de/tourenauskunft/stadt_gera_app.php');
        break;
      case "25":

      case "26":
        Navigator.pushNamed(context, Routes.subDiscoveryScreen,
            arguments: service);
        break;
    }

    /*await launchUrl(Uri.parse('https://mitreden.ilzerland.bayern/ringelai'),
          mode: LaunchMode.inAppWebView);*/
  }

/*void _showCitySelectionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Stadt Auswählen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Translate.of(context).translate('please_select_city')),
              const SizedBox(height: 16),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }*/
}
