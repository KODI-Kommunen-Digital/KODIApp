import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_cart_item.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_seller_order.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/translate.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel? order;
  final SellerOrderModel? sellerOrder;

  const OrderDetailsScreen(
      {super.key, required this.order, required this.sellerOrder});

  @override
  Widget build(BuildContext context) {
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
                          order!.createdAt ?? '',
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
                            return AppProductItem(
                                type: ProductViewType.list,
                                isRefreshLoader: false,
                                item: ProductModel(
                                    id: product.id,
                                    title: product.title,
                                    image: ((product.productImages ?? [])
                                            .isNotEmpty
                                        ? product.productImages!.first
                                        : ''),
                                    //Default product image
                                    expiryDate: '',
                                    startDate: '',
                                    endDate: '',
                                    createDate: product.createdAt ?? '',
                                    favorite: false,
                                    address: '',
                                    phone: '',
                                    email: '',
                                    website: '',
                                    externalId: '',
                                    description: product.description,
                                    userId: product.sellerId));
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
