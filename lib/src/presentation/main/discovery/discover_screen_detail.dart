import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';

class DiscoveryScreenDetail extends StatelessWidget {
  const DiscoveryScreenDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final selectedCityId = args['id'] as int;
    final List<CitizenServiceModel> services = args['services'];

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
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              if (services[index].categoryId != null &&
                  services[index].categoryId != 0) {
                Navigator.pushNamed(context, Routes.listProduct, arguments: {
                  'id': selectedCityId,
                  'title': '',
                  'type': services[index].type,
                  'subCategoryId': services[index].subCategoryId
                });
                final prefs = await Preferences.openBox();
                prefs.setKeyValue(
                    Preferences.categoryId, services[index].categoryId);
                prefs.setKeyValue(Preferences.type, services[index].type);
              } else if (services[index].imageUrl == "8.4" &&
                  services[index].categoryId == 0) {
                final item = ProductModel(
                  id: 511,
                  allCities: [2],
                  title: '',
                  image: '',
                  expiryDate: '',
                  startDate: '',
                  endDate: '',
                  createDate: '',
                  favorite: false,
                  address: '',
                  phone: '',
                  email: '',
                  website: '',
                  externalId: '',
                  description: '',
                  button: "Jetzt bestellen",
                  userId: 4,
                );
                Navigator.pushNamed(context, Routes.productDetail,
                    arguments: item);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                services[index].imageLink,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
