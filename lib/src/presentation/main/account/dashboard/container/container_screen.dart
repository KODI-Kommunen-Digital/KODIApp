import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/widget/app_grid_item.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class ContainerScreen extends StatelessWidget {
  const ContainerScreen({super.key});

  Future<UserModel?> getUser() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    final user = await UserRepository.fetchUser(userId);
    if (user != null) {
      //TODO change once integration
      Map<String, bool> permissions =
          await ContainerRepository.getUserPermission(userId);
      user.updateUser(permissions: permissions);
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate("Container")),
        ),
        body: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserModel? user = snapshot.data;
              return Center(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16.0),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: <Widget>[
                    if (user?.permissions?['Customer'] == true)
                      GridItemButton(
                        icon: Icons.shopping_cart,
                        title: Translate.of(context).translate("customer"),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.customerScreen);
                        },
                      ),
                    GridItemButton(
                      icon: Icons.sell,
                      title: Translate.of(context).translate("seller"),
                      onPressed: () {
                        if (user?.permissions?['Seller'] == true) {
                          Navigator.pushNamed(context, Routes.sellerScreen,
                              arguments: {'user': user});
                        } else {
                          Navigator.pushNamed(context, Routes.sellerRequest);
                        }
                      },
                    ),
                    if (user?.permissions?['Owner'] == true)
                      GridItemButton(
                        icon: Icons.house,
                        title: Translate.of(context).translate("owner"),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.ownerScreen);
                        },
                      ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(Translate.of(context).translate("error_message")),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
