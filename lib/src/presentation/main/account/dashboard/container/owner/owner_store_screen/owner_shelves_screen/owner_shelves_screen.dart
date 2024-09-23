// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_shelves_screen/cubit/owner_shelves_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_shelves_screen/cubit/owner_shelves_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class OwnerShelvesScreen extends StatefulWidget {
  final StoreModel store;

  const OwnerShelvesScreen({super.key, required this.store});

  @override
  State<OwnerShelvesScreen> createState() => _OwnerShelvesScreenState();
}

class _OwnerShelvesScreenState extends State<OwnerShelvesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OwnerShelvesCubit>().store = widget.store;
    context.read<OwnerShelvesCubit>().onLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerShelvesCubit, OwnerShelvesState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const OwnerShelvesLoading(),
            loaded: (shelves, categories, subCategories) => OwnerShelvesLoaded(
                  shelves: shelves,
                  categories: categories,
                  subCategories: subCategories,
                  store: widget.store,
                ),
            orElse: () => ErrorWidget("Failed to load listings.")));
  }
}

class OwnerShelvesLoaded extends StatefulWidget {
  final List<ShelfModel> shelves;
  final List<CategoryModel> categories;
  final List<CategoryModel> subCategories;
  final StoreModel store;

  const OwnerShelvesLoaded(
      {super.key,
      required this.shelves,
      required this.categories,
      required this.subCategories,
      required this.store});

  @override
  State<OwnerShelvesLoaded> createState() => _OwnerShelvesLoadedState();
}

class _OwnerShelvesLoadedState extends State<OwnerShelvesLoaded> {
  List<ShelfModel> shelves = [];
  final ScrollController _scrollController = ScrollController();
  int pageNo = 1;
  bool isLoadingMore = false;

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        final newShelves =
            await context.read<OwnerShelvesCubit>().newShelves(++pageNo);
        shelves.addAll(newShelves);
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    shelves.addAll(widget.shelves);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  String? getCategoryTranslation(int id) {
    try {
      CategoryModel? category =
          widget.categories.firstWhere((element) => element.id == id);
      return category.title;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    return Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate('shelves')),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, Routes.addShelfScreen,
                arguments: {'store': widget.store}).then((success) {
              if (success != null && success == true) {
                context.read<OwnerShelvesCubit>().onLoad(false);
              }
            });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: (shelves.isNotEmpty)
            ? ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, int index) {
                  if (index < shelves.length) {
                    ShelfModel item = shelves[index];
                    ContainerProductModel? product = item.product;
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.shelfDetailScreen,
                            arguments: {
                              'shelf': item,
                              'categories': widget.categories,
                              'subCategories': widget.subCategories
                            }).then((success) {
                          if (success != null && success == true) {
                            context.read<OwnerShelvesCubit>().onLoad(false);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Stack(
                          children: [
                            Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: ((product?.productImages ?? [])
                                            .isNotEmpty)
                                        ? '${Application.picturesURL}${product!.productImages!.last}'
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
                                        item.title ?? product?.title ?? '',
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        (product != null)
                                            ? getCategoryTranslation(
                                                    product.categoryId) ??
                                                ''
                                            : '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                          item.description ??
                                              product?.description ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!),
                                      const SizedBox(height: 4),
                                      Text(
                                        (product != null)
                                            ? "${Translate.of(context).translate('quantity')}: ${product.inventory.toString()}"
                                            : "${Translate.of(context).translate('quantity')}: ${Translate.of(context).translate('undefined')}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${Translate.of(context).translate('price')}: ${(item.pricePerQuantity ?? product?.price ?? Translate.of(context).translate('undefined')).toString()}${(item.pricePerQuantity == null && product?.price == null) ? '' : '€'}",
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
                                )
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
                itemCount: shelves.length + 1,
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

class OwnerShelvesLoading extends StatelessWidget {
  const OwnerShelvesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
