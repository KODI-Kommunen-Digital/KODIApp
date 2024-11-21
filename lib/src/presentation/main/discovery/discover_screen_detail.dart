import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';

class DiscoveryScreenDetail extends StatelessWidget {
  const DiscoveryScreenDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final selectedCityId = args['id'] as int;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Services'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: 300.0,
        ),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              Navigator.pushNamed(context, Routes.listProduct, arguments: {
                'id': selectedCityId,
                'title': '',
                'type': 'category'
              });
              final prefs = await Preferences.openBox();
              prefs.setKeyValue(Preferences.categoryId, index == 0 ? 29 : 12);
              prefs.setKeyValue(Preferences.type, "category");
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                index == 0 ? Images.service29 : Images.service12,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
