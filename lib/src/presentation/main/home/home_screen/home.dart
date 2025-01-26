// ignore_for_file: no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

enum InfoWidget { events, current, officialNotification, clubs }

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
  final _currentScrollController = ScrollController();
  final _eventsScrollController = ScrollController();
  final _officialNotificationScrollController = ScrollController();
  final _clubsScrollController = ScrollController();
  bool isLoadingCurrent = false;
  bool isLoadingEvents = false;
  bool isLoadingClubs = false;
  bool isLoadingOfficialNotification = false;
  bool categoryLoading = false;
  bool locationLoading = false;
  bool isRefreshLoader = false;
  String? banner;
  List<CategoryModel>? category = [];
  List<CategoryModel>? location = [];
  List<ProductModel>? current = [];
  List<ProductModel>? events = [];
  List<ProductModel>? officialNotification = [];
  List<ProductModel>? clubs = [];
  List<CitizenServiceModel>? services = [];
  AppUpdateInfo? _updateInfo;
  late double screenHeight;
  late double screenWidth;
  late double screenAverage;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    super.initState();
    _currentScrollController.addListener(_currentScrollListener);
    _eventsScrollController.addListener(_eventsScrollListener);
    _officialNotificationScrollController
        .addListener(_officialNotificationScrollListener);
    _clubsScrollController.addListener(_clubsScrollListener);
    checkSavedCity = true;
    AppBloc.homeCubit.onLoad(false);
    connectivityInternet();
    checkUserExist();
    checkForUpdate();
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
    _officialNotificationScrollController
        .removeListener(_officialNotificationScrollListener);
    _clubsScrollController.removeListener(_clubsScrollListener);
    _currentScrollController.removeListener(_currentScrollListener);
    _eventsScrollController.removeListener(_eventsScrollListener);

    _officialNotificationScrollController.dispose();
    _clubsScrollController.dispose();
    _eventsScrollController.dispose();
    _currentScrollController.dispose();
  }

  Future<void> checkUserExist() async {
    bool exists = await AppBloc.homeCubit.doesUserExist();
    if (!exists) {
      AppBloc.loginCubit.onLogout();
    }
  }

  Future<void> _currentScrollListener() async {
    if (_currentScrollController.position.atEdge) {
      if (_currentScrollController.position.pixels != 0) {
        setState(() {
          isLoadingCurrent = true;
        });
        current =
            await AppBloc.homeCubit.newListings(++newsPageNo, 0).then((_) {
          setState(() {
            isLoadingCurrent = false;
          });
        }).catchError(
          (error, stackTrace) async {
            setState(() {
              isLoadingCurrent = false;
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
        events =
            await AppBloc.homeCubit.newListings(++eventsPageNo, 3).then((_) {
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

  Future<void> _clubsScrollListener() async {
    if (_clubsScrollController.position.atEdge) {
      if (_clubsScrollController.position.pixels != 0) {
        setState(() {
          isLoadingClubs = true;
        });
        clubs =
            await AppBloc.homeCubit.newListings(++eventsPageNo, 4).then((_) {
          setState(() {
            isLoadingClubs = false;
          });
        }).catchError(
          (error, stackTrace) async {
            setState(() {
              isLoadingClubs = false;
            });
            logError('Error loading new clubs: $error');
            await Sentry.captureException(error, stackTrace: stackTrace);
          },
        );
      }
    }
  }

  Future<void> _officialNotificationScrollListener() async {
    if (_officialNotificationScrollController.position.atEdge) {
      if (_officialNotificationScrollController.position.pixels != 0) {
        setState(() {
          isLoadingOfficialNotification = true;
        });
        officialNotification =
            await AppBloc.homeCubit.newListings(++eventsPageNo, 16).then((_) {
          setState(() {
            isLoadingOfficialNotification = false;
          });
        }).catchError(
          (error, stackTrace) async {
            setState(() {
              isLoadingOfficialNotification = false;
            });
            logError('Error loading new official notifications: $error');
            await Sentry.captureException(error, stackTrace: stackTrace);
          },
        );
      }
    }
  }

  void scrollUp() {
    _currentScrollController.animateTo(0,
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
            current = state.current;
            events = state.events;
            officialNotification = state.officialNotification;
            clubs = state.clubs;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: _buildItems(events, InfoWidget.events)),
                      const SizedBox(
                        width: 32,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildItems(current, InfoWidget.current),
                            const SizedBox(
                              height: 16,
                            ),
                            _buildItems(officialNotification,
                                InfoWidget.officialNotification),
                            const SizedBox(
                              height: 16,
                            ),
                            _buildItems(clubs, InfoWidget.clubs),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      )
                    ],
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

  Widget _buildItems(List<ProductModel>? items, InfoWidget infoWidget) {
    late String title;
    bool isVertical = false;
    late ScrollController controller;
    late bool isLoading;

    switch (infoWidget) {
      case InfoWidget.current:
        title = 'current';
        controller = _currentScrollController;
        isLoading = isLoadingCurrent;
        break;
      case InfoWidget.clubs:
        title = 'category_clubs';
        controller = _clubsScrollController;
        isLoading = isLoadingClubs;
        break;
      case InfoWidget.officialNotification:
        title = 'category_official_notification';
        controller = _officialNotificationScrollController;
        isLoading = isLoadingOfficialNotification;
        break;
      case InfoWidget.events:
        title = "events_today";
        controller = _eventsScrollController;
        isLoading = isLoadingEvents;
        isVertical = true;
        break;
    }

    return AppTerminalContainer(
      height: (isVertical) ? screenHeight * 0.85 : screenHeight * 0.27,
      round: true,
      screenAverage: screenAverage,
      centerWidgets: true,
      title: Translate.of(context).translate(title),
      widgets: [
        if (!isVertical)
          SizedBox(
            height: screenHeight * 0.015,
          ),
        ((items ?? []).isNotEmpty)
            ? Expanded(
                child: Row(
                  children: [
                    (isVertical)
                        ? const SizedBox(
                            width: 12,
                          )
                        : const SizedBox(
                            width: 2,
                          ),
                    if (!isVertical)
                      Icon(Icons.arrow_back_ios,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    Expanded(
                      child: RawScrollbar(
                        controller: controller,
                        scrollbarOrientation: ScrollbarOrientation.right,
                        thumbColor: Theme.of(context).scaffoldBackgroundColor,
                        radius: const Radius.circular(16),
                        thickness: 15.0,
                        thumbVisibility: true,
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection:
                                (isVertical) ? Axis.vertical : Axis.horizontal,
                            controller: controller,
                            itemCount: items!.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index < items.length) {
                                ProductModel product = items[index];
                                return Center(
                                  child: Padding(
                                    padding: (isVertical)
                                        ? const EdgeInsets.symmetric(
                                            vertical: 12)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 1),
                                    child: AppProductItem(
                                      type: ProductViewType.terminal,
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      categoryTitle: Translate.of(context)
                                          .translate('recent'),
                                      isRefreshLoader: isRefreshLoader,
                                      item: product,
                                      onPressed: () {
                                        _onProductDetail(product);
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return (isLoading)
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Container();
                              }
                            }),
                      ),
                    ),
                    if (!isVertical)
                      Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    (isVertical)
                        ? const SizedBox(
                            width: 12,
                          )
                        : const SizedBox(
                            width: 2,
                          ),
                  ],
                ),
              )
            : (categoryLoading)
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
