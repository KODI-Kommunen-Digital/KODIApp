import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/widget/app_grid_item.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class StoreDetailScreen extends StatelessWidget {
  final StoreModel store;

  const StoreDetailScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('store')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              if (store.description != null) const SizedBox(height: 16),
              if (store.description != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(store.description!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!),
                  ],
                ),
              if (store.address != null) const SizedBox(height: 4),
              if (store.address != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${Translate.of(context).translate('address')}:",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(store.address ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              if (store.address != null) const SizedBox(height: 16),
              GridView.count(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16.0),
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: <Widget>[
                  GridItemButton(
                    icon: Icons.inventory,
                    title: Translate.of(context).translate("shelves"),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.ownerShelvesScreen,
                          arguments: {'store': store});
                    },
                  ),
                  GridItemButton(
                    icon: Icons.person,
                    title: Translate.of(context).translate("seller"),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.ownerSellerScreen,
                          arguments: {'store': store});
                    },
                  ),
                  GridItemButton(
                    icon: Icons.shopping_cart_sharp,
                    title: Translate.of(context).translate("orders"),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.ownerOrdersScreen,
                          arguments: {'store': store});
                    },
                  ),
                  GridItemButton(
                    icon: Icons.shopping_bag,
                    title: Translate.of(context).translate("products"),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.ownerProductsScreen,
                          arguments: {'store': store});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
