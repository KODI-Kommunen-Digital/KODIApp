import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/widget/app_grid_item.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class DashboardScreen extends StatelessWidget {
  final bool isEditable;

  const DashboardScreen({required this.isEditable, super.key});

  Future<UserModel?> getUser() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    final user = await UserRepository.fetchUser(userId);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate("dashboard")),
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
                    if (user?.roleId == 1)
                      GridItemButton(
                        icon: Icons.group,
                        title: Translate.of(context).translate("requests"),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(Routes.allRequests, arguments: {
                            "user": user,
                          });
                        },
                      ),
                    if (user?.roleId == 1)
                      GridItemButton(
                        icon: Icons.list,
                        title: Translate.of(context).translate("all_listings"),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(Routes.allListings, arguments: {
                            "user": user,
                          });
                        },
                      ),
                    GridItemButton(
                      icon: Icons.local_offer,
                      title: Translate.of(context).translate("my_listings"),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.myListings,
                          arguments: {'user': user, 'editable': true},
                        );
                      },
                    ),
                    GridItemButton(
                      icon: Icons.group,
                      title: Translate.of(context).translate("my_groups"),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.myGroups,
                        );
                        // Add your action here
                      },
                    ),
                    GridItemButton(
                      icon: Icons.store,
                      title: Translate.of(context).translate("Container"),
                      onPressed: () {
                        if(user != null) {
                          Navigator.pushNamed(
                            context,
                            Routes.containerScreen,
                          );
                        } else {
                          Navigator.pushNamed(context, Routes.signIn);
                        }
                        // Add your action here
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
