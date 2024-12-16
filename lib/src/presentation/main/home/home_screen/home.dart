// ignore_for_file: no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/presentation/widget/app_terminal_container.dart';

import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCityTitle = '';
  int selectedCityId = 0;
  int newsPageNo = 1;
  int eventsPageNo = 1;
  late bool checkSavedCity;
  final _newsScrollController = ScrollController();
  final _eventsScrollController = ScrollController();
  bool isLoadingNews = false;
  bool isLoadingEvents = false;
  bool categoryLoading = false;
  bool locationLoading = false;
  bool isRefreshLoader = false;
  String? banner;
  List<CategoryModel>? category = [];
  List<CategoryModel>? location = [];
  List<ProductModel>? news = [];
  List<ProductModel>? events = [];
  List<CitizenServiceModel>? services = [];
  AppUpdateInfo? _updateInfo;
  PermissionStatus? locationPermission;
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
      ),
    )
    ..loadRequest(Uri.parse('https://troisdorf.dksr.city/poimap/'));
  late double screenHeight;
  late double screenWidth;
  late double screenAverage;
  final String mapLink = 'https://troisdorf.dksr.city/poimap/';
  final String statisticsLink =
      'https://troisdorf.dksr.city/public-dashboards/4ce486ba9c294808bb58ba19a88e19fa?orgId=1';
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    super.initState();
    _newsScrollController.addListener(_newsScrollListener);
    _eventsScrollController.addListener(_eventsScrollListener);
    checkSavedCity = true;
    AppBloc.homeCubit.onLoad(false);
    connectivityInternet();
    checkUserExist();
    checkForUpdate();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    locationPermission = await Permission.location.request();
    if (isLocationAllowed()) {
      await _getLocation();
    } else if (locationPermission != PermissionStatus.permanentlyDenied) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(Translate.of(context).translate("geo_permission_needed"))));
      _requestLocationPermission();
    } else {
      bool opened = await openAppSettings();
      if (opened) {
        locationPermission = await Permission.location.status;
      }
    }
  }

  Future<void> _getLocation() async {
    setState(() {
      locationLoading = true;
    });
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      locationLoading = false;
    });
  }

  bool isLocationAllowed() {
    if (locationPermission != null) {
      if (locationPermission!.isGranted ||
          locationPermission!.isProvisional ||
          locationPermission!.isLimited) {
        return true;
      }
    }
    return false;
  }

  /*Future<bool> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context).translate('geo_permission_needed'),
            textAlign: TextAlign.center),
      ));
      return false;
    }
    return true;
  }*/

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
      liveUpdate();
    }).catchError((e) {
      logError(e.toString());
    });
  }

  Future<void> liveUpdate() async {
    if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
      final performUpdate = await showUpdateMessage();
      if (performUpdate) {
        InAppUpdate.performImmediateUpdate().catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(Translate.of(context).translate('error_message'))));
          return AppUpdateResult.inAppUpdateFailed;
        });
      }
    }
  }

  Future<bool> showUpdateMessage() async {
    bool update = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('update_available')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Translate.of(context).translate('update_available_message')),
              const SizedBox(height: 16),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                update = true;
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(Translate.of(context).translate('later')),
            ),
          ],
        );
      },
    );
    return update;
  }

  void connectivityInternet() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      AppBloc.homeCubit.onLoad(false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _newsScrollController.removeListener(_newsScrollListener);
    _eventsScrollController.removeListener(_eventsScrollListener);
    _newsScrollController.dispose();
    _eventsScrollController.dispose();
  }

  Future<void> checkUserExist() async {
    bool exists = await AppBloc.homeCubit.doesUserExist();
    if (!exists) {
      AppBloc.loginCubit.onLogout();
    }
  }

  Future<void> _newsScrollListener() async {
    if (_newsScrollController.position.atEdge) {
      if (_newsScrollController.position.pixels != 0) {
        setState(() {
          isLoadingNews = true;
        });
        news =
            await AppBloc.homeCubit.newListings(++newsPageNo, true).then((_) {
          setState(() {
            isLoadingNews = false;
          });
        }).catchError(
          (error, stackTrace) async {
            setState(() {
              isLoadingNews = false;
            });
            logError('Error loading new news: $error');
            await Sentry.captureException(error, stackTrace: stackTrace);
          },
        );
      }
    }
  }

  Future<void> _eventsScrollListener() async {
    if (_eventsScrollController.position.atEdge) {
      if (_eventsScrollController.position.pixels != 0) {
        setState(() {
          isLoadingEvents = true;
        });
        events = await AppBloc.homeCubit
            .newListings(++eventsPageNo, false)
            .then((_) {
          setState(() {
            isLoadingEvents = false;
          });
        }).catchError(
          (error, stackTrace) async {
            setState(() {
              isLoadingEvents = false;
            });
            logError('Error loading new events: $error');
            await Sentry.captureException(error, stackTrace: stackTrace);
          },
        );
      }
    }
  }

  void scrollUp() {
    _newsScrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }

  Future<void> _setSavedCity(List<CategoryModel> location) async {
    final savedCity = await AppBloc.homeCubit.checkSavedCity(location);
    if (savedCity != null) {
      setState(() {
        selectedCityId = savedCity.id;
        selectedCityTitle = savedCity.title;
      });
    } else {
      await AppBloc.homeCubit.saveCityId(0);
      setState(() {
        selectedCityId = 0;
      });
    }
    //AppBloc.homeCubit.onLoad(true);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenAverage = (screenHeight + screenWidth) / 2;
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(Translate.of(context).translate('no_internet')),
              duration: const Duration(seconds: 4),
            )),
            orElse: () {},
          );
        },
        builder: (context, state) {
          List<String> cityTitles = [
            Translate.of(context).translate('select_location')
          ];

          if (state is HomeStateLoaded) {
            banner = state.banner;
            category = state.category;
            location = state.location;
            news = state.news;
            events = state.events;
            services = state.services;
            isRefreshLoader = true;
            categoryLoading = false;

            if (location != null) {
              for (final ids in location!) {
                cityTitles.add(ids.title.toString());
              }
              if (checkSavedCity) {
                checkSavedCity = false;
                _setSavedCity(location!);
              } else if (AppBloc.homeCubit.getCalledExternally()) {
                _setSavedCity(location!);
                AppBloc.homeCubit.setCalledExternally(false);
              }
            }
            if (AppBloc.homeCubit.getDoesScroll()) {
              AppBloc.homeCubit.setDoesScroll(false);
              scrollUp();
            }
          }

          if (state is HomeStatecategoryLoading) {
            categoryLoading = true;
            location = state.location;
            if (location!.isNotEmpty) {
              for (final ids in location!) {
                cityTitles.add(ids.title.toString());
              }
              if (checkSavedCity) {
                checkSavedCity = false;
                _setSavedCity(location!);
              }
            }
          }

          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd.MM.yyyy, HH:mm:ss')
                                  .format(DateTime.now()),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenAverage * 0.02),
                            ),
                          ],
                        );
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildItems(news, categoryLoading, true),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildItems(events, categoryLoading, false),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildMap(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildStatistics(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildQRCodes(),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String getServiceUrl(int id) {
    switch (id) {
      case 4:
        return "https://www.troisdorf.de/de/rathaus-service/buergerservice/neubuergerpaket/";
      case 6:
        return "https://onlinedienste.troisdorf.de/";
      case 7:
        return "https://www.stadtwerke-troisdorf.de/";
      case 8:
        return "https://geoportal.troisdorf.de/app.php/application/mobile";
      default:
        return "";
    }
  }

  void _makeAction(String link) async {
    if (!link.startsWith("https://") && !link.startsWith("http://")) {
      link = "https://$link";
    }
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(link));

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        link,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 30,
                child: WebViewWidget(
                  controller: webViewController,
                  gestureRecognizers: gestureRecognizers,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onProductDetail(ProductModel item) {
    if (item.sourceId == 2 || item.showExternal == 1) {
      _makeAction(item.website);
    } else if (item.showExternal == 0) {
      Navigator.pushNamed(context, Routes.productDetail, arguments: item);
    } else {
      Navigator.pushNamed(context, Routes.productDetail, arguments: item);
    }
  }

  Widget _buildQRCodes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppTerminalContainer(
          width: screenAverage * 0.15,
          height: screenAverage * 0.15 + screenAverage * 0.025,
          round: true,
          centerWidgets: true,
          widgets: [
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "App",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: screenAverage * 0.015,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            QrImageView(data: 'https://www.smart-app-troisdorf.de')
          ],
        ),
        AppTerminalContainer(
          width: screenAverage * 0.15,
          height: screenAverage * 0.15 + screenAverage * 0.025,
          round: true,
          centerWidgets: true,
          widgets: [
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mobilitätskarte",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: screenAverage * 0.015,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            QrImageView(data: 'https://troisdorf.dksr.city/map/')
          ],
        ),
        AppTerminalContainer(
          width: screenAverage * 0.15,
          height: screenAverage * 0.15 + screenAverage * 0.025,
          round: true,
          centerWidgets: true,
          widgets: [
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Stadt Troisdorf",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: screenAverage * 0.015,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            QrImageView(data: 'https://www.troisdorf.de')
          ],
        ),
      ],
    );
  }

  Widget _buildStatistics() {
    /*WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(statisticsLink));
    return Container(
      height: 200,
      child: WebViewWidget(controller: controller),
    );*/

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AppTerminalContainer(
          backgroundColor: const Color(0xFF97c3c5),
          height: screenHeight * 0.1,
          width: screenWidth * 0.4,
          round: true,
          centerWidgets: true,
          widgets: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_walk, size: screenAverage * 0.05),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "111",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: screenAverage * 0.03),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.2,
                    child: Text(
                      "Wieviele Menschen sind heute zu Fuß unterwegs?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: screenAverage * 0.015),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        AppTerminalContainer(
          backgroundColor: const Color(0xFF9abb8f),
          height: screenHeight * 0.1,
          width: screenWidth * 0.4,
          round: true,
          centerWidgets: true,
          widgets: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_bike,
                  size: screenAverage * 0.05,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "58",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: screenAverage * 0.03),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.2,
                    child: Text(
                      "Wieviele Menschen sind heute mit dem Rad unterwegs?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: screenAverage * 0.015),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildMap() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: (isLocationAllowed())
                        ? InAppWebView(
                            initialUrlRequest: URLRequest(url: WebUri(mapLink)),
                            initialSettings: InAppWebViewSettings(
                              javaScriptEnabled: true,
                              geolocationEnabled: true,
                              domStorageEnabled: true,
                              allowFileAccess: true,
                              useWideViewPort: true,
                              mediaPlaybackRequiresUserGesture: false,
                            ),
                            onGeolocationPermissionsShowPrompt:
                                (controller, origin) async {
                              return GeolocationPermissionShowPromptResponse(
                                  origin: origin, allow: true, retain: true);
                            },
                            onPermissionRequest: (controller, request) async {
                              return PermissionResponse(
                                  resources: request.resources,
                                  action: PermissionResponseAction.GRANT);
                            },
                            onWebViewCreated: (controller) {
                              controller = controller;
                            },
                          )
                        : (locationPermission == null ||
                                locationPermission!.isPermanentlyDenied)
                            ? Container(
                                color: Theme.of(context).shadowColor,
                                child: TextButton(
                                    onPressed: () async {
                                      await openAppSettings();
                                      _requestLocationPermission();
                                    },
                                    child: Text(
                                      Translate.of(context).translate(
                                          'geo_permission_needed_settings'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: screenAverage * 0.03),
                                    )),
                              )
                            : (locationLoading)
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container()),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          /*
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AppButton(Translate.of(context).translate('mobility'),
                    color: (mapLink == 'https://troisdorf.dksr.city/map/')
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).scaffoldBackgroundColor,
                    outlineColor: Colors.white, onPressed: () {
                  setState(() {
                    mapLink = 'https://troisdorf.dksr.city/map/';
                  });
                }),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: AppButton('POI',
                    color: (mapLink == 'https://troisdorf.dksr.city/poimap/')
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).scaffoldBackgroundColor,
                    outlineColor: Colors.white, onPressed: () {
                  setState(() {
                    mapLink = 'https://troisdorf.dksr.city/poimap/';
                  });
                }),
              ),
            ],
          )*/
        ],
      ),
    );
  }

  Widget _buildItems(
      List<ProductModel>? items, bool isLoadingInit, bool isNews) {
    return AppTerminalContainer(
      height: screenHeight * 0.12,
      round: true,
      screenAverage: screenAverage,
      title: Translate.of(context)
          .translate((isNews) ? 'recent_listings' : 'category_events'),
      widgets: [
        ((items ?? []).isNotEmpty)
            ? Expanded(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 2,
                    ),
                    Icon(Icons.arrow_back_ios,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    Expanded(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          controller: (isNews)
                              ? _newsScrollController
                              : _eventsScrollController,
                          itemCount: items!.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < items.length) {
                              ProductModel product = items[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: AppProductItem(
                                  type: ProductViewType.terminal,
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  isEvent: !isNews,
                                  categoryTitle:
                                      Translate.of(context).translate('recent'),
                                  isRefreshLoader: isRefreshLoader,
                                  item: product,
                                  onPressed: () {
                                    _onProductDetail(product);
                                  },
                                ),
                              );
                            } else {
                              return ((isNews)
                                      ? isLoadingNews
                                      : isLoadingEvents)
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container();
                            }
                          }),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    const SizedBox(
                      width: 2,
                    ),
                  ],
                ),
              )
            : (isLoadingInit)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            Translate.of(context).translate('list_is_empty'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Colors.black,
                                    fontSize: screenAverage * 0.02),
                          ),
                        ),
                      ],
                    ),
                  ),
      ],
    );
  }

  Future<void> navigateToLink(CitizenServiceModel service) async {
    // if (service.imageLink == "1") {
    //   await launchUrl(Uri.parse('https://mitreden.ilzerland.bayern/ringelai'),
    //       mode: LaunchMode.inAppWebView);
    // } else if (service.imageLink == "2") {
    //   await launchUrl(
    //       Uri.parse(await AppBloc.homeCubit.getCityLink() ?? ""),
    //       mode: LaunchMode.inAppWebView);
    // } else if (service.imageLink == "10") {
    //   final cityId = await context.read<homeCubit>().getCitySelected();
    //   if (cityId != 0) {
    //     if (!mounted) return;
    //     Navigator.pushNamed(context, Routes.listGroups,
    //         arguments: {'id': service.arguments, 'title': 'forums'});
    //   } else {
    //     if (!mounted) return;
    //     _showCitySelectionPopup(context);
    //   }
    // }
    if (service.imageLink == "3" ||
        service.imageLink == "4" ||
        service.imageLink == "5" ||
        service.imageLink == "6" ||
        service.imageLink == "7" ||
        service.imageLink == "9" ||
        service.imageLink == "11") {
      await launchUrl(
          Uri.parse(
              await AppBloc.homeCubit.getServiceLink(service.imageLink) ?? ""),
          mode: LaunchMode.inAppWebView);
    } else if (service.imageLink == "8") {
      _onSubmit();
    } else if (service.imageLink == "10") {
    } else {
      AppBloc.homeCubit.setServiceValue(Preferences.type, service.type, null);
      if (service.categoryId != null) {
        AppBloc.homeCubit
            .setServiceValue(Preferences.categoryId, null, service.categoryId);
      }
      Navigator.pushNamed(context, Routes.listProduct, arguments: {
        'id': service.arguments,
        'title': '',
        'type': 'categoryService'
      });
    }
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
}
