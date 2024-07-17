import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/translate.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${Translate.of(context).translate('order')}: ${order.id}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  order.createdAt ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  itemCount: order.shelves.length,
                  itemBuilder: (context, index) {
                    final product = order.shelves[index].product;
                    return AppProductItem(
                        type: ProductViewType.list,
                        isRefreshLoader: false,
                        item: ProductModel(
                            id: product.id,
                            title: product.title,
                            image: ((product.productImages ?? []).isNotEmpty
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
        ),
      ),
    );
  }
}
