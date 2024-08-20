// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_products_screen/cubit/owner_products_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_products_screen/cubit/owner_products_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class OwnerProductsScreen extends StatefulWidget {
  final StoreModel store;

  const OwnerProductsScreen({super.key, required this.store});

  @override
  State<OwnerProductsScreen> createState() => _OwnerProductsScreenState();
}

class _OwnerProductsScreenState extends State<OwnerProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OwnerProductsCubit>().store = widget.store;
    context.read<OwnerProductsCubit>().onLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerProductsCubit, OwnerProductsState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const OwnerProductsLoading(),
            loaded: (products, requests, categories, subCategories) =>
                OwnerProductsLoaded(
                  products: products,
                  requests: requests,
                  categories: categories,
                  subCategories: subCategories,
                ),
            orElse: () => ErrorWidget("Failed to load listings.")));
  }
}

class OwnerProductsLoaded extends StatefulWidget {
  final List<ContainerProductModel> products;
  final List<ProductRequestModel> requests;
  final List<CategoryModel> categories;
  final List<CategoryModel> subCategories;

  const OwnerProductsLoaded(
      {super.key,
      required this.products,
      required this.categories,
      required this.subCategories,
      required this.requests});

  @override
  State<OwnerProductsLoaded> createState() => _OwnerProductsLoadedState();
}

class _OwnerProductsLoadedState extends State<OwnerProductsLoaded> {
  final ScrollController _scrollController = ScrollController();
  List<ContainerProductModel> products = [];

  bool isLoadingMore = false;
  int pageNo = 1;

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        final newProducts =
            await context.read<OwnerProductsCubit>().newProducts(++pageNo);
        products.addAll(newProducts);
        setState(() {
          isLoadingMore = false;
        });
      }
    }
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
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDeleteConfirmation(item);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: Text(Translate.of(context).translate('delete')),
                  ),
                ),
              ]);
        });
  }

  void updateProduct(ContainerProductModel item) async {
    await Navigator.pushNamed(context, Routes.createProductScreen,
        arguments: {'product': item, 'sellerId': item.sellerId});
    context.read<OwnerProductsCubit>().onLoad(false);
  }

  Future<void> showDeleteConfirmation(ContainerProductModel item) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('delete_Confirmation')),
          content: Text(
              Translate.of(context).translate('are_you_sure_delete_product')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: Text(Translate.of(context).translate('yes')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(Translate.of(context).translate('no')),
            ),
          ],
        );
      },
    );

    if (result) {
      final success =
          await context.read<OwnerProductsCubit>().deleteProduct(item);
      late String message;
      if (success) {
        message = Translate.of(context).translate('delete_product_success');
        context.read<OwnerProductsCubit>().onLoad(false);
      } else {
        message = Translate.of(context).translate('error_message');
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    products.addAll(widget.products);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    return Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate('products')),
          centerTitle: true,
          actions: [
            AppButton(Translate.of(context).translate('requests'),
                type: ButtonType.text, onPressed: () {
              Navigator.pushNamed(context, Routes.productRequestScreen,
                  arguments: {"requests": widget.requests});
            })
          ],
        ),
        body: (products.isNotEmpty)
            ? ListView.builder(
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
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: ((item.productImages ?? [])
                                            .isNotEmpty)
                                        ? '${Application.picturesURL}${item.productImages!.first}'
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
                                    imageBuilder: (context, imageProvider) {
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
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
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
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        getCategoryTranslation(item.categoryId),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
              ));
  }
}

class OwnerProductsLoading extends StatelessWidget {
  const OwnerProductsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
