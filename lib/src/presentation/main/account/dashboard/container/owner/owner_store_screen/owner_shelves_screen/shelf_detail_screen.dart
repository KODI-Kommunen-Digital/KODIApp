// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class ShelfDetailsScreen extends StatefulWidget {
  final ShelfModel shelf;
  final List<CategoryModel> categories;
  final List<CategoryModel>? subCategories;

  const ShelfDetailsScreen(
      {super.key,
      required this.shelf,
      required this.categories,
      this.subCategories});

  @override
  State<ShelfDetailsScreen> createState() => _ShelfDetailsScreenState();
}

class _ShelfDetailsScreenState extends State<ShelfDetailsScreen> {
  bool expandTitle = false;
  bool expandDescription = false;

  @override
  Widget build(BuildContext context) {
    final ContainerProductModel? product = widget.shelf.product;
    final memoryCacheManager = DefaultCacheManager();
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('shelf_details')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.shelf.product != null)
                  CachedNetworkImage(
                    imageUrl: ((widget.shelf.product!.productImages ?? [])
                            .isNotEmpty)
                        ? '${Application.picturesURL}${widget.shelf.product!.productImages!.first}'
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
                InkWell(
                  onTap: () {
                    setState(() {
                      expandTitle = !expandTitle;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.shelf.title ??
                              product?.title ??
                              Translate.of(context).translate('undefined'),
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          overflow: (expandTitle)
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon((expandTitle)
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      expandDescription = !expandDescription;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.shelf.description ??
                              product?.description ??
                              Translate.of(context).translate('undefined'),
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: (expandDescription)
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon((expandDescription)
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (product != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translate.of(context).translate('product'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.title,
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
                      "${widget.shelf.pricePerQuantity ?? product?.price ?? Translate.of(context).translate('undefined')}${(widget.shelf.pricePerQuantity == null && product == null) ? '' : '€'}",
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
                      widget.shelf.formatDate(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                if (product != null)
                  const SizedBox(
                    height: 32,
                  ),
                if (product != null)
                  AppButton(Translate.of(context).translate('remove_product'),
                      onPressed: () {
                    showRemoveProductDialog(context);
                  })
              ],
            )),
      ),
    );
  }

  Future<void> showRemoveProductDialog(BuildContext buildContext) async {
    final result = await showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('remove_product')),
          content: Text(
              Translate.of(context).translate('are_you_sure_remove_product')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final bool success =
                    await ContainerRepository.removeProductFromShelf(
                        widget.shelf.id);
                if (success) {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        Translate.of(context).translate("error_message"),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(Translate.of(context).translate('yes')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // No
              child: Text(Translate.of(context).translate('no')),
            ),
          ],
        );
      },
    );
    if (result == true) {}
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

  String? getSubCategoryTranslation(int id) {
    try {
      if (widget.subCategories != null) {
        CategoryModel? category =
            widget.subCategories!.firstWhere((element) => element.id == id);
        return category.title;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
