// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';

import 'package:heidi/src/presentation/widget/app_filter_button.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class SellerProductsScreen extends StatefulWidget {
  final UserModel user;

  const SellerProductsScreen({super.key, required this.user});

  @override
  State<SellerProductsScreen> createState() => _SellerOrderScreenState();
}

class _SellerOrderScreenState extends State<SellerProductsScreen> {
  @override
  void initState() {
    context.read<SellerCubit>().onLoad(false, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      builder: (context, state) => state.maybeWhen(
          loading: () => const SellerProductsLoading(),
          loadedProducts: (products, productRequests, categories, subCategories,
                  stores, selectedStore) =>
              SellerProductsLoaded(
                products: products ?? [],
                productRequests: productRequests ?? [],
                categories: categories ?? [],
                subCategories: subCategories ?? [],
                stores: stores,
                selectedStore: selectedStore,
                user: widget.user,
              ),
          orElse: () => ErrorWidget("Failed to load listings.")),
    );
  }
}

class SellerProductsLoaded extends StatefulWidget {
  final List<ContainerProductModel> products;
  final List<ProductRequestModel> productRequests;
  final UserModel user;
  final List<CategoryModel> categories;
  final List<CategoryModel> subCategories;
  final List<StoreModel> stores;
  final StoreModel? selectedStore;

  const SellerProductsLoaded(
      {super.key,
      required this.products,
      required this.productRequests,
      required this.user,
      required this.categories,
      required this.subCategories,
      required this.stores,
      required this.selectedStore});

  @override
  State<SellerProductsLoaded> createState() => _SellerLoadedState();
}

class _SellerLoadedState extends State<SellerProductsLoaded> {
  final ScrollController _scrollController = ScrollController();
  late MultiFilter filter;
  List<ContainerProductModel> products = [];
  int pageNo = 1;
  bool isLoadingMore = false;
  int? selectedStore;

  @override
  void initState() {
    super.initState();
    products.addAll(widget.products);
    _scrollController.addListener(_scrollListener);
    if (widget.selectedStore != null) {
      selectedStore = widget.selectedStore!.id;
    }
    filter = MultiFilter(
        hasContainerSellerFilter: true,
        isContainerProductsBySeller:
            context.read<SellerCubit>().loadMyProducts ?? false);
    context.read<SellerCubit>().loadMyProducts = false;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        final newProducts =
            await context.read<SellerCubit>().newProducts(++pageNo);
        products.addAll(newProducts);
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('products')),
        centerTitle: true,
        actions: [
          AppButton(
            Translate.of(context).translate('requests'),
            onPressed: () {
              updateRequest();
            },
            type: ButtonType.text,
          ),
          AppFilterButton(
              multiFilter: filter,
              filterCallBack: (newFilter) {
                setState(() {
                  filter = newFilter;
                });
                context.read<SellerCubit>().loadMyProducts =
                    filter.isContainerProductsBySeller;
                context.read<SellerCubit>().onLoad(false, true);
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            DropdownButton<int>(
              isExpanded: false,
              hint: Text(Translate.of(context).translate('choose_store')),
              value: selectedStore,
              onChanged: (chosen) async {
                if (chosen != null) {
                  context.read<SellerCubit>().store =
                      widget.stores.firstWhere((store) => store.id == chosen);
                  context.read<SellerCubit>().onLoad(false, true);
                }
              },
              items: widget.stores
                  .map((store) => DropdownMenuItem<int>(
                        value: store.id,
                        child: Text(store.name),
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            (products.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, int index) {
                        if (index < products.length) {
                          ContainerProductModel item = products[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.containerProductDetailScreen,
                                  arguments: {'product': item});
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl: ((item.productImages ?? [])
                                                  .isNotEmpty)
                                              ? '${Application.picturesURL}${item.productImages!.last}'
                                              : '${Application.picturesURL}admin/News.jpeg',
                                          cacheManager: memoryCacheManager,
                                          placeholder: (context, url) {
                                            return AppPlaceholder(
                                              child: Container(
                                                height: 140,
                                                width: 120,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                              width: 120,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            );
                                          },
                                          errorWidget: (context, url, error) {
                                            return AppPlaceholder(
                                              child: Container(
                                                width: 120,
                                                height: 140,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                                child: const Icon(Icons.error),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Text(
                                              item.title,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              getCategoryTranslation(
                                                  item.categoryId),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                                getSubCategoryTranslation(
                                                    item.subCategoryId),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!),
                                            const SizedBox(height: 4),
                                            Text(
                                              "${Translate.of(context).translate('quantity')}: ${item.inventory.toString()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "${Translate.of(context).translate('price')}: ${item.price.toString()}€",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              item.formatDate(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _openStoreActionPopUp(item);
                                          },
                                          icon: const Icon(Icons.more_vert))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return (isLoadingMore)
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                )
                              : Container();
                        }
                      },
                      itemCount: products.length + 1,
                    ),
                  )
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.sentiment_satisfied),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            Translate.of(context).translate('list_is_empty'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, Routes.createProductScreen,
              arguments: {'sellerId': widget.user.id});
        },
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _openStoreActionPopUp(ContainerProductModel item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Center(
                child: Text(Translate.of(context).translate('options'),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                    updateProduct(item);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.edit),
                    title: Text(Translate.of(context).translate('edit')),
                  ),
                ),
              ]);
        });
  }

  void updateProduct(ContainerProductModel item) async {
    await Navigator.pushNamed(context, Routes.createProductScreen,
        arguments: {'product': item, 'sellerId': widget.user.id});
    context.read<SellerCubit>().onLoad(false, true);
  }

  void updateRequest() async {
    await Navigator.pushNamed(context, Routes.productRequestScreen,
        arguments: {"requests": widget.productRequests, "isOwner": false});
    context.read<SellerCubit>().onLoad(false, true);
  }

  String getCategoryTranslation(int id) {
    try {
      CategoryModel? category =
          widget.categories.firstWhere((element) => element.id == id);
      return category.title;
    } catch (e) {
      return '';
    }
  }

  String getSubCategoryTranslation(int id) {
    try {
      CategoryModel? category =
          widget.subCategories.firstWhere((element) => element.id == id);
      return category.title;
    } catch (e) {
      return '';
    }
  }
}

class SellerProductsLoading extends StatelessWidget {
  const SellerProductsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('products')),
        centerTitle: true,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
