import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/main/home/widget/empty_product_item.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/custom_cache_manager.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class AppProductItem extends StatelessWidget {
  const AppProductItem(
      {super.key,
      this.item,
      this.onPressed,
      required this.type,
      this.trailing,
      required this.isRefreshLoader,
      this.cityName});

  final ProductModel? item;
  final ProductViewType type;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final bool isRefreshLoader;
  final String? cityName;


   // String? _validateImageUrl(String? url) {
  //   if (url == null || url.isEmpty) return null;
  //
  //   // Check for common image formats
  //   final validExtensions = ['.jpg', '.jpeg', '.png', '.webp', '.gif'];
  //   final hasValidExtension = validExtensions.any((ext) => url.toLowerCase().contains(ext));
  //
  //   if (!hasValidExtension) {
  //     debugPrint('Invalid image URL format: $url');
  //     return null;
  //   }
  //
  //   return url;
  // }

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();
    final memoryCacheManager = DefaultCacheManager();

    String imageUrl = item?.sourceId == 2 &&
        item?.image != null &&
        item?.image != 'admin/News.jpeg'
        ? item!.image
        : item?.sourceId == 3 && item?.image != null
        ? (item!.image.startsWith('admin')
        ? "${Application.picturesURL}${item!.image}"
        : item!.image)
        : item?.image != null &&
        item!.image.startsWith('admin')
        ? "${Application.picturesURL}${item!.image}"
        : "${Application.picturesURL}${item?.image ?? 'admin/News.jpeg'}";


    imageUrl = imageUrl == "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_13/city_1_listing_307_1" ||
        imageUrl == "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_14/city_1_listing_320_1" ||
        imageUrl == "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_14/city_1_listing_219_1" ||
        imageUrl == "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_13/city_1_listing_193_1" ||
    //     imageUrl == "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_200/city_1_listing_711_1_1747913235095" ||
    //     imageUrl == "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_72/city_1_listing_339_1_1738234861117" ||
    //     imageUrl == "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_124/city_1_listing_363_1_1738868236754" ||
    //     imageUrl ==  "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_24/city_1_listing_214_1_1751624003864" ||
    // imageUrl ==  "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_6/city_1_listing_98_1_1730799345585" ||
    // imageUrl ==  "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_6/city_1_listing_96_1_1730799104736" ||

        imageUrl == "https://www.stockheim-online.de" ? "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/user_24/city_1_listing_310_1_1737989508482" : imageUrl;

    // imageUrl = _validateImageUrl(imageUrl) ?? "https://stockheim1heidi.obs.eu-de.otc.t-systems.com/admin/Events/Defaultimage6.png";

    // debugPrint("Network image links - $imageUrl");

    switch (type) {
      case ProductViewType.small:
        if (item == null) {
          return const EmptyProductItem();
        }
        return InkWell(
          onTap: () async {
            onPressed!();
          },
          child: Row(
            children: <Widget>[
              item?.pdf != '' && item?.image == 'admin/News.jpeg'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                          width: 120,
                          height: 140,
                          child: const PDF().cachedFromUrl(
                            "${Application.picturesURL}${item?.pdf}?cacheKey=$uniqueKey",
                            placeholder: (progress) =>
                                Center(child: Text('$progress %')),
                            errorWidget: (error) =>
                                Center(child: Text(error.toString())),
                          )),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        // memCacheWidth: 300,
                        // memCacheHeight: 300,
                        useOldImageOnUrlChange: true,
                        imageUrl: imageUrl,
                        cacheManager: memoryCacheManager,
                        placeholder: (context, url) {
                          return AppPlaceholder(
                            child: Container(
                              width: 120,
                              height: 140,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/listing_default_image.png'),
                                  fit: BoxFit.cover,
                                ),
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
                          debugPrint('Invalid image URL format: $url $error');
                          return Container(
                            width: 120,
                            height: 140,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/listing_default_image.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item!.title,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      (cityName != null)
                          ? "${item?.category ?? ''} - $cityName"
                          : item?.category ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Visibility(
                      visible: item!.startDate.isNotEmpty &&
                          item!.endDate.isNotEmpty,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            "${item?.startDate} ${Translate.of(context).translate('to')} ${item?.endDate}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          item!.startDate.isNotEmpty && item!.endDate == "",
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            "${item?.startDate}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: item?.categoryId == 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            "${item?.createDate}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (item?.sourceId == 3)
                      Text(
                        "${Translate.of(context).translate('quelle')} ${item?.externalId ?? ''}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                      ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
              trailing ?? Container()
            ],
          ),
        );
      case ProductViewType.grid:
        if (item == null) {
          return const EmptyProductItem();
        }

        return InkWell(
          onTap: () async {
            onPressed!();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: imageUrl,
                cacheManager: memoryCacheManager,
                // memCacheWidth: 300,
                // memCacheHeight: 300,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                item!.favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                placeholder: (context, url) {
                  return Container(
                    height: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/listing_default_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  debugPrint('Invalid image URL format: $url');
                  return Container(
                    height: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/listing_default_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                item?.category ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                item!.title,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              Text(
                item!.address,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (item?.sourceId == 3)
                Text(
                  "${Translate.of(context).translate('quelle')} ${item?.externalId ?? ''}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                ),
            ],
          ),
        );

      case ProductViewType.list:
        if (item == null) {
          return const EmptyProductItem();
        }

        return InkWell(
          onTap: () async {
            onPressed!();
          },
          child: Stack(
            children: [
              Row(
                children: <Widget>[
                  item?.pdf != '' && item?.image == 'admin/News.jpeg'
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                              width: 120,
                              height: 140,
                              child: const PDF().cachedFromUrl(
                                "${Application.picturesURL}${item?.pdf}?cacheKey=$uniqueKey",
                                placeholder: (progress) =>
                                    Center(child: Text('$progress %')),
                                errorWidget: (error) =>
                                    Center(child: Text(error.toString())),
                              )),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            // memCacheWidth: 300,
                            // memCacheHeight: 300,
                            useOldImageOnUrlChange: true,
                            imageUrl: imageUrl,
                            cacheManager: memoryCacheManager,
                            placeholder: (context, url) {
                              return Container(
                                width: 120,
                                height: 140,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/listing_default_image.png'),
                                    fit: BoxFit.cover,
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
                              debugPrint('Invalid image URL format: $url');
                              return Container(
                                width: 120,
                                height: 140,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/listing_default_image.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item!.title,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          (cityName != null)
                              ? "${item?.category ?? ''} - $cityName"
                              : item?.category ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        if (item?.categoryId == 3)
                          Container(
                            padding: const EdgeInsets.all(3.5),
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item?.endDate == ""
                                  ? "${item?.startDate}"
                                  : "${item?.startDate} ${Translate.of(context).translate('to')} ${item?.endDate}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        Text(
                          item?.categoryId == 1 ? "${item?.createDate}" : "",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        if (item?.sourceId == 3)
                          Text(
                            "${Translate.of(context).translate('quelle')} ${item?.externalId ?? ''}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.w600),
                            maxLines: 2,
                          ),
                        const SizedBox(height: 4),
                        const SizedBox(height: 8),
                        const Row(
                          children: <Widget>[
                            SizedBox(width: 4),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );

      default:
        return Container(width: 160.0);
    }
  }

  Future<void> savePDFLocally(String pdfContent) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$pdfContent';
    final file = File(filePath);

    if (!await file.exists()) {
      await file.writeAsBytes(pdfContent.codeUnits);
    }
  }
}
