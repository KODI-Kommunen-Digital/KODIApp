import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/presentation/widget/app_grid_item.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class SellerSelectScreen extends StatelessWidget {
  final UserModel user;
  const SellerSelectScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('seller')),
        centerTitle: true,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: <Widget>[
            GridItemButton(
              icon: Icons.shopping_cart,
              title: Translate.of(context).translate("orders"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.sellerOrderScreen,
                  arguments: {'user': user, 'editable': true},
                );
              },
            ),
            GridItemButton(
              icon: Icons.emoji_food_beverage,
              title: Translate.of(context).translate("products"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.sellerProductsScreen,
                  arguments: {'user': user, 'editable': true},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
