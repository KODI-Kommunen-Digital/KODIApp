import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heidi/src/data/model/model_cart_item.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_seller_order.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel? order;
  final SellerOrderModel? sellerOrder;

  const OrderDetailsScreen(
      {super.key, required this.order, required this.sellerOrder});

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('order_details')),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (order != null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${Translate.of(context).translate('order')}: ${order!.id}',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          order!.formatDate(),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: order!.shelves.length,
                          itemBuilder: (context, index) {
                            final product = order!.shelves[index].product;
                            final shelf = order!.shelves[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl: ((product!
                                                            .productImages ??
                                                        [])
                                                    .isNotEmpty)
                                                ? '${Application.picturesURL}${product.productImages!.last}'
                                                : '${Application.picturesURL}admin/News.jpeg',
                                            cacheManager: memoryCacheManager,
                                            placeholder: (context, url) {
                                              return AppPlaceholder(
                                                child: Container(
                                                  height: 140,
                                                  width: 120,
                                                  decoration:
                                                      const BoxDecoration(
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
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
                                                "${Translate.of(context).translate('name')}: ${product.title}",
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              if (product.description != null)
                                                const SizedBox(height: 8),
                                              if (product.description != null)
                                                Html(
                                                    data: ContainerRepository
                                                        .removeDoubleEnumHtml(
                                                            product
                                                                .description!)),
                                              const SizedBox(height: 4),
                                              Text(
                                                "${Translate.of(context).translate('price_per_quantity')}: ${shelf.pricePerQuantity.toString()}€",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              const SizedBox(height: 8),
                                              const SizedBox(height: 4),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )
              : (sellerOrder != null)
                  ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (context, index) {
                        CartItemModel item = sellerOrder!.cartItems[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Stack(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Text(
                                          item.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${item.totalPrice.toString()}€',
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${Translate.of(context).translate('price_per_product')}: ${item.pricePerQuantity.toString()}€',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${Translate.of(context).translate('quantity')}: ${item.quantity}',
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
                                        const SizedBox(height: 8),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: sellerOrder!.cartItems.length,
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
                    )),
    );
  }
}
