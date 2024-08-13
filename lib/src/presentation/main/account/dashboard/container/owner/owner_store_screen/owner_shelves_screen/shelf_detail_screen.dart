import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class ShelfDetailsScreen extends StatelessWidget {
  final ShelfModel shelf;
  final List<CategoryModel> categories;
  final List<CategoryModel>? subCategories;

  const ShelfDetailsScreen(
      {super.key,
      required this.shelf,
      required this.categories,
      this.subCategories});

  @override
  Widget build(BuildContext context) {
    final ContainerProductModel? product = shelf.product;
    final memoryCacheManager = DefaultCacheManager();
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('order_details')),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (shelf.product != null)
                CachedNetworkImage(
                  imageUrl: ((shelf.product!.productImages ?? []).isNotEmpty)
                      ? '${Application.picturesURL}${shelf.product!.productImages!.first}'
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
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    shelf.title ??
                        product?.title ??
                        Translate.of(context).translate('undefined'),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    shelf.description ??
                        product?.description ??
                        Translate.of(context).translate('undefined'),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
                const SizedBox(
                  height: 16,
                ),
              if (product != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translate.of(context).translate('category'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      getCategoryTranslation(product.categoryId) ??
                          Translate.of(context).translate('undefined'),
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              if (product != null)
                const SizedBox(
                  height: 8,
                ),
              if (product != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translate.of(context).translate('subCategory'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      getSubCategoryTranslation(product.subCategoryId) ??
                          Translate.of(context).translate('undefined'),
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Translate.of(context).translate('price'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${shelf.pricePerQuantity ?? product?.price ?? Translate.of(context).translate('undefined')}${(shelf.pricePerQuantity == null && product == null) ? '' : '€'}",
                    style: Theme.of(context).textTheme.bodyMedium!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              if (product != null)
                const SizedBox(
                  height: 8,
                ),
              if (product != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translate.of(context).translate('tax'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.tax.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              if (product != null)
                const SizedBox(
                  height: 8,
                ),
              if (product != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translate.of(context).translate('inventory'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.inventory.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              if (product != null)
                const SizedBox(
                  height: 8,
                ),
              if (product != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translate.of(context).translate('min_count'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.minCount.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              if (product != null)
                const SizedBox(
                  height: 8,
                ),
              if (product != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translate.of(context).translate('seller'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.sellerId.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    shelf.formatDate(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          )),
    );
  }

  String? getCategoryTranslation(int id) {
    try {
      CategoryModel? category =
          categories.firstWhere((element) => element.id == id);
      return category.title;
    } catch (e) {
      return null;
    }
  }

  String? getSubCategoryTranslation(int id) {
    try {
      if (subCategories != null) {
        CategoryModel? category =
            subCategories!.firstWhere((element) => element.id == id);
        return category.title;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
