// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
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
                        //Implement Image Zoom later
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
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        ),
                                        child: Image.network(
                                          imageUrlString,
                                          fit: BoxFit.fitHeight,
                                          loadingBuilder: (BuildContext context,
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
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child:
                                                      const Icon(Icons.error),
                                                ),
                                              );
                                            }
                                          },
                                        ),
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
}
