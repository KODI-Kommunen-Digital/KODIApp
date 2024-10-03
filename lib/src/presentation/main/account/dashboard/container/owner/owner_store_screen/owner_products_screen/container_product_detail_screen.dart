// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'dart:math' as math;

class ContainerProductDetailScreen extends StatefulWidget {
  final ContainerProductModel product;

  const ContainerProductDetailScreen({super.key, required this.product});

  @override
  State<ContainerProductDetailScreen> createState() =>
      _ContainerProductDetailScreenState();
}

class _ContainerProductDetailScreenState
    extends State<ContainerProductDetailScreen> {
  int currentImageIndex = 0;

  double getCarouselHeight() {
    double carouselHeight = 0;
    if (Platform.isAndroid) {
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      double safeAreaVertical = MediaQuery.of(context).padding.top +
          MediaQuery.of(context).padding.bottom +
          kToolbarHeight;
      double aspectRatio = screenWidth / screenHeight;
      double maxCarouselHeight = 350;
      double targetHeightRatioPortrait = 0.35;
      double targetHeightRatioLandscape = 0.3;
      if (aspectRatio > 1.0) {
        carouselHeight =
            screenHeight * targetHeightRatioLandscape - safeAreaVertical;
      } else {
        carouselHeight =
            screenHeight * targetHeightRatioPortrait - safeAreaVertical;
      }
      carouselHeight = math.min(carouselHeight, maxCarouselHeight);
    } else if (Platform.isIOS) {
      double screenHeight = MediaQuery.of(context).size.height;
      double safeAreaVertical = MediaQuery.of(context).padding.top +
          MediaQuery.of(context).padding.bottom;
      double targetHeightRatio = 0.35;
      carouselHeight = (screenHeight - safeAreaVertical) * targetHeightRatio;
    }
    return carouselHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('product')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if ((widget.product.productImages ?? []).isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    height: getCarouselHeight() + 50,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.forumImageZoom,
                            arguments:
                                "${Application.picturesURL}${widget.product.productImages![currentImageIndex]}");
                      },
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  aspectRatio: 1 /
                                      MediaQuery.of(context).devicePixelRatio,
                                  height: getCarouselHeight(),
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  enableInfiniteScroll:
                                      widget.product.productImages!.length > 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentImageIndex = index;
                                    });
                                  },
                                ),
                                items: widget.product.productImages
                                    ?.map((imageUrl) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      String? imageUrlString =
                                          '${Application.picturesURL}$imageUrl';
                                      return Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                            ),
                                            child: Image.network(
                                              imageUrlString,
                                              fit: BoxFit.fitHeight,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return AppPlaceholder(
                                                    child: Container(
                                                      width: 120,
                                                      height: 140,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8),
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                          Icons.error),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                  onPressed: () {
                                                    showDeleteConfirmation();
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    size: 30,
                                                    color: Colors.red,
                                                  )))
                                        ],
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              if (widget.product.productImages!.length > 1)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: widget.product.productImages!
                                        .map((url) {
                                      int index = widget.product.productImages!
                                          .indexOf(url);
                                      return Container(
                                        width: 10.0,
                                        height: 10.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: currentImageIndex == index
                                              ? Colors.blueAccent
                                              : Colors.grey,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                      widget.product.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
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
                      widget.product.sellerId.toString(),
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
                      widget.product.price.toString(),
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
                      Translate.of(context).translate('tax'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.product.tax.toString(),
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
                      Translate.of(context).translate('inventory'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.product.inventory.toString(),
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
                      Translate.of(context).translate('min_count'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.product.minCount.toString(),
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
                      Translate.of(context).translate('max_count'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.product.maxCount.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!,
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
                      'ID',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.product.id.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!,
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
                      Translate.of(context).translate('status'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      Translate.of(context).translate(
                          (widget.product.isActive) ? 'active' : 'inactive'),
                      style: Theme.of(context).textTheme.bodyMedium!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.product.formatDate(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                if (ContainerRepository.isValidBarcode(
                    widget.product.barcode ?? ''))
                  const SizedBox(
                    height: 64,
                  ),
                if (ContainerRepository.isValidBarcode(
                    widget.product.barcode ?? ''))
                  SizedBox(
                      height: 120,
                      width: 400,
                      child: SfBarcodeGenerator(
                        value: widget.product.barcode,
                        showValue: true,
                        symbology: (widget.product.barcode!.length == 12)
                            ? UPCA()
                            : EAN13(),
                      ))
              ],
            )),
      ),
    );
  }

  Future<void> showDeleteConfirmation() async {
    String message = Translate.of(context).translate('error_message');
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('delete_Confirmation')),
          content: Text(
              Translate.of(context).translate('are_you_sure_remove_image')),
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

    if (result == true) {
      bool success = await ContainerRepository.deleteContainerImage(
          widget.product.cityId,
          widget.product.shopId,
          widget.product.id,
          widget.product.productImages![currentImageIndex]);
      if (success) {
        message = Translate.of(context).translate('success');
        Navigator.pop(context);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }
}
