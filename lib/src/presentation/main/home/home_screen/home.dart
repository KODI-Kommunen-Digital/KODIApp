
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_in_app_webview/custom_in_app_webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/home_screen/cubit/home_cubit.dart';
import 'package:heidi/src/presentation/main/home/home_screen/cubit/home_state.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/cubit.dart';
import 'package:heidi/src/presentation/main/home/widget/banner_slider.dart';
import 'package:heidi/src/presentation/main/home/widget/home_category_item.dart';
import 'package:heidi/src/presentation/main/home/widget/home_sliver_app_bar.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../list_product/list_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollCompanyController = ScrollController();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  int _companyPageNo = 1;
  bool _isCompanyLoadingMore = false;
  String _ignoreAppStoreVersion = '';
  String _latestAppStoreVersion = '';

  @override
  void initState() {
    super.initState();
    _scrollCompanyController.addListener(_onScrollCompany);
    _loadInitialData();
    _listenToConnectivity();
    _checkUserExist();
    _loadIgnoreAppVersion();
  }

  @override
  void dispose() {
    _scrollCompanyController.removeListener(_onScrollCompany);
    _scrollCompanyController.dispose();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    await AppBloc.homeCubit.onLoad(false);
    if (mounted) {
      context.read<ListCubit>().onLoad(1); // 1 -> News category Id
    }
  }

  void _listenToConnectivity() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((_) => AppBloc.homeCubit.onLoad(false));
  }

  Future<void> _checkUserExist() async {
    final exists = await AppBloc.homeCubit.doesUserExist();
    if (!exists && mounted) {
      AppBloc.loginCubit.onLogout();
    }
  }

  Future<void> _loadIgnoreAppVersion() async {
    final ignoreVersion = await AppBloc.homeCubit.getIgnoreAppVersion();
    if (mounted) {
      setState(() {
        _ignoreAppStoreVersion = ignoreVersion;
      });
    }
  }

  Future<void> _onScrollCompany() async {
    if (_scrollCompanyController.position.pixels >=
            _scrollCompanyController.position.maxScrollExtent &&
        !_isCompanyLoadingMore) {
      setState(() {
        _isCompanyLoadingMore = true;
      });
      try {
        await AppBloc.homeCubit.newCompanies(++_companyPageNo);
      } catch (error, stackTrace) {
        logError('Error loading new companies: $error');
        await Sentry.captureException(error, stackTrace: stackTrace);
      } finally {
        if (mounted) {
          setState(() {
            _isCompanyLoadingMore = false;
          });
        }
      }
    }
  }

  Future<void> _onRefresh() async {
    _companyPageNo = 1;
    await _loadInitialData();
  }

  void _onProductDetail(ProductModel item) {
    if (item.sourceId == 2 || item.showExternal == 1) {
      _openUrl(item.website);
    } else {
      Navigator.pushNamed(context, Routes.productDetail, arguments: item);
    }
  }

  Future<void> _onCategory(
      CategoryModel item, List<CategoryModel> allCategories) async {
    if (item.id == -1) {
      _showAllCategories(allCategories);
      return;
    }

    if (item.id == 17) { // Groups
      final prefs = await Preferences.openBox();
      final cityId = prefs.getKeyValue(Preferences.cityId, 0);
      if (cityId != 0) {
        if (mounted) {
          Navigator.pushNamed(context, Routes.listGroups,
              arguments: {'id': item.id, 'title': 'Gruppen'});
        }
      } else {
        if (mounted) {
          _showCitySelectionPopup();
        }
      }
    } else if (item.hasChild) {
      final prefs = await Preferences.openBox();
      prefs.setKeyValue(Preferences.categoryId, item.id);
      prefs.setKeyValue(Preferences.type, "category");
      if (mounted) {
        Navigator.pushNamed(context, Routes.listProduct,
            arguments: {'id': item.id, 'title': ''});
      }
    } else {
      _showCategoryComingSoon();
    }
  }

  Future<void> _onService(CategoryModel item) async {
    switch (item.id) {
      case 4:
        await launchUrl(Uri.parse("https://freiraum-fichtelgebirge.de/"),
            mode: LaunchMode.inAppWebView);
        break;
      case 5:
        if (mounted) {
          Navigator.pushNamed(context, Routes.contactForm);
        }
        break;
      case 10:
        _openUrl("https://freiraum-fichtelgebirge.de/unternehmensverzeichnis/");
        break;
    }
  }

  void _openUrl(String url) {
    if (!url.startsWith(RegExp(r'https?:\/\/'))) {
      url = "https://$url";
    }
    CustomInAppWebView.showAsBottomSheet(context: context, url: url);
  }

  void _showAllCategories(List<CategoryModel> allCategories) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => _AllCategoriesSheet(
        allCategories: allCategories,
        onCategorySelected: (category) => _onCategory(category, allCategories),
      ),
    );
  }

  void _showCategoryComingSoon() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(Translate.of(context).translate('categorization')),
        content: Text(Translate.of(context).translate("category_coming_soon")),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCitySelectionPopup() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(Translate.of(context).translate('input_city')),
        content: Text(Translate.of(context).translate('please_select_city')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        upgrader: _ignoreAppStoreVersion == _latestAppStoreVersion
            ? null
            : Upgrader(
                debugLogging: true,
                debugDisplayAlways: true,
                countryCode: 'DE',
                durationUntilAlertAgain: const Duration(seconds: 30),
                willDisplayUpgrade: ({
                  required bool display,
                  String? installedVersion,
                  UpgraderVersionInfo? versionInfo,
                }) {
                  if (display) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _latestAppStoreVersion =
                              versionInfo?.appStoreVersion?.toString() ?? '';
                        });
                      }
                    });
                  }
                },
              ),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(Translate.of(context).translate('no_internet')),
                ),
              ),
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              categoryLoading: (location) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (error) => Center(child: Text(error)),
              loaded: (banner, category, location, recent, company,
                  isRefreshLoader) {
                return _HomeContent(
                  banner: banner,
                  categories: category,
                  companies: company,
                  scrollCompanyController: _scrollCompanyController,
                  isCompanyLoadingMore: _isCompanyLoadingMore,
                  onRefresh: _onRefresh,
                  onCategorySelected: _onCategory,
                  onServiceSelected: _onService,
                  onProductSelected: _onProductDetail,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.banner,
    required this.categories,
    required this.companies,
    required this.scrollCompanyController,
    required this.isCompanyLoadingMore,
    required this.onRefresh,
    required this.onCategorySelected,
    required this.onServiceSelected,
    required this.onProductSelected,
  });

  final String? banner;
  final List<CategoryModel>? categories;
  final List<ProductModel>? companies;
  final ScrollController scrollCompanyController;
  final bool isCompanyLoadingMore;
  final Future<void> Function() onRefresh;
  final Future<void> Function(CategoryModel, List<CategoryModel>) onCategorySelected;
  final Future<void> Function(CategoryModel) onServiceSelected;
  final void Function(ProductModel) onProductSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: AppBarHomeSliver(
              cityTitlesList: [],
              hintText: Translate.of(context).translate('search_title'),
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              banners: banner,
              setLocationCallback: (data) async {
                final prefs = await Preferences.openBox();
                prefs.setKeyValue(Preferences.type, 'search');
                if (context.mounted) {
                  Navigator.pushNamed(context, Routes.listProduct,
                      arguments: {'search': data, 'title': 'Suche'});
                }
              },
            ),
            pinned: true,
          ),
          CupertinoSliverRefreshControl(onRefresh: onRefresh),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 6),
                _CategoryGrid(
                  categories: categories,
                  onCategorySelected: onCategorySelected,
                  onServiceSelected: onServiceSelected,
                ),
                const BannerSlider(),
                const SizedBox(height: 16),
                _CompanyList(
                  companies: companies,
                  scrollController: scrollCompanyController,
                  isLoadingMore: isCompanyLoadingMore,
                  onProductSelected: onProductSelected,
                ),
                const _NewsSection(),
                const SizedBox(height: 16),
                const _FooterLogos(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({
    required this.categories,
    required this.onCategorySelected,
    required this.onServiceSelected,
  });

  final List<CategoryModel>? categories;
  final Future<void> Function(CategoryModel, List<CategoryModel>) onCategorySelected;
  final Future<void> Function(CategoryModel) onServiceSelected;

  @override
  Widget build(BuildContext context) {
    if (categories == null || categories!.isEmpty) {
      return Wrap(
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: List.generate(8, (_) => const HomeCategoryItem()),
      );
    }

    final allCategories = categories!;
    List<CategoryModel> displayedCategories = allCategories;
    if (allCategories.length >= 7) {
      displayedCategories = allCategories.take(7).toList();
      displayedCategories.add(
        CategoryModel.fromJson({
          "id": -1,
          "name": Translate.of(context).translate("more"),
          "icon": "fas fa-ellipsis",
          "color": "#36454F",
        }),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: displayedCategories.map((item) {
          return HomeCategoryItem(
            item: item,
            onPressed: (item) {
              final serviceIds = {4, 5, 6, 7, 8, 10};
              if (serviceIds.contains(item.id)) {
                onServiceSelected(item);
              } else {
                onCategorySelected(item, allCategories);
              }
              return false;
            },
          );
        }).toList(),
      ),
    );
  }
}

class _CompanyList extends StatelessWidget {
  const _CompanyList({
    required this.companies,
    required this.scrollController,
    required this.isLoadingMore,
    required this.onProductSelected,
  });

  final List<ProductModel>? companies;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final void Function(ProductModel) onProductSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translate.of(context).translate('do_you_know'),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            Translate.of(context).translate('company_matching'),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Container(
            height: 180,
            padding: const EdgeInsets.only(top: 4),
            child: (companies == null || companies!.isEmpty)
                ? _buildPlaceholder()
                : _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(0),
      scrollDirection: Axis.horizontal,
      itemCount: companies!.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < companies!.length) {
          final item = companies![index];
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: AppProductItem(
              onPressed: () => onProductSelected(item),
              item: item,
              type: ProductViewType.card, 
              isRefreshLoader: false,
            ),
          );
        }
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }

  Widget _buildPlaceholder() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(left: 8),
          child: AppProductItem(type: ProductViewType.small, isRefreshLoader: false,),
        );
      },
    );
  }
}

class _NewsSection extends StatelessWidget {
  const _NewsSection();

  @override
  Widget build(BuildContext context) {
    final ProductViewType listMode = Application.setting.listMode;

    void onProductDetail(ProductModel item) {
      if (item.sourceId == 2 || item.showExternal == 1) {
        String url = item.website;
        if (!url.startsWith(RegExp(r'https?:\/\/'))) {
          url = "https://$url";
        }
        CustomInAppWebView.showAsBottomSheet(context: context, url: url);
      } else {
        Navigator.pushNamed(context, Routes.productDetail, arguments: item);
      }
    }

    Widget buildItem({ProductModel? item, required ProductViewType type}) {
      final padding = const EdgeInsets.symmetric(horizontal: 16);
      if (type == ProductViewType.list) {
        return Container(
          padding: padding,
          child: AppProductItem(
            onPressed: item != null ? () => onProductDetail(item) : null,
            item: item,
            type: listMode, 
            isRefreshLoader: false,
          ),
        );
      }
      return AppProductItem(
        onPressed: item != null ? () => onProductDetail(item) : null,
        item: item,
        type: listMode,
        isRefreshLoader: false,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            Translate.of(context).translate('news_listing'),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        BlocBuilder<ListCubit, ListState>(
          builder: (context, state) {
            return state.when(
              loading: () => const ListLoading(),
              loaded: (_, newsList) => _buildNewsList(context,newsList, listMode, buildItem),
              updated: (_, newsList) => _buildNewsList(context,newsList, listMode, buildItem),
              error: (e) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(Translate.of(context).translate('list_is_empty')),
              ),
              initial: () => const SizedBox.shrink(),
            );
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () async {
              final prefs = await Preferences.openBox();
              prefs.setKeyValue(Preferences.categoryId, 1); // 1 for News
              prefs.setKeyValue(Preferences.type, "category");
              if (context.mounted) {
                Navigator.pushNamed(context, Routes.listProduct, arguments: {
                  'id': 1,
                  'title': '',
                  'type': 'category',
                });
              }
            },
            child: Text(
              Translate.of(context).translate('more_news'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsList(
      BuildContext context,
    List<ProductModel>? list,
    ProductViewType listMode,
    Widget Function({ProductModel? item, required ProductViewType type}) buildItem,
  ) {
    if (list == null || list.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.sentiment_satisfied),
              const SizedBox(width: 4),
              Text(
                Translate.of(context).translate('list_is_empty'),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: (list.length < 3) ? list.length : 3,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 5),
          child: buildItem(item: list[index], type: listMode),
        );
      },
    );
  }
}

class _AllCategoriesSheet extends StatelessWidget {
  const _AllCategoriesSheet({
    required this.allCategories,
    required this.onCategorySelected,
  });

  final List<CategoryModel> allCategories;
  final void Function(CategoryModel) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Translate.of(context).translate('all_Categories'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Wrap(
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: allCategories.map((item) {
              return HomeCategoryItem(
                item: item,
                onPressed: (item) {
                  Navigator.pop(context);
                  onCategorySelected(item);
                  return false;
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _FooterLogos extends StatelessWidget {
  const _FooterLogos();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _FooterLogo(asset: 'assets/images/home/energie_logo.png'),
          _FooterLogo(asset: 'assets/images/home/bayerisches_logo.jpg'),
          _FooterLogo(asset: 'assets/images/home/heimat_logo.png'),
        ],
      ),
    );
  }
}

class _FooterLogo extends StatelessWidget {
  final String asset;

  const _FooterLogo({required this.asset});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Image.asset(
        asset,
        width: 100,
        height: 50,
        fit: BoxFit.contain,
        cacheWidth: 200,
        cacheHeight: 100,
        filterQuality: FilterQuality.low,
      ),
    );
  }
}
