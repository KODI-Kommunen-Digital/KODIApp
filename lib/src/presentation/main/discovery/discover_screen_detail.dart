import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscoveryScreenDetail extends StatelessWidget {
  const DiscoveryScreenDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final selectedCityId = args['id'] as int?;
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
              if (services[index].imageUrl == "31.2") {
                if (selectedCityId == null || selectedCityId == 0) {
                  _showCitySelectionPopup(context);
                } else {
                  _openCitySpecificLink(context, selectedCityId);
                }
              } else if (services[index].categoryId != null &&
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
                  cityId: 2,
                  categoryId: 1,
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

  void _showCitySelectionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text(Translate.of(context).translate('please_select_city_title')),
          content: Text(Translate.of(context).translate('please_select_city')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(Translate.of(context).translate('ok')),
            ),
          ],
        );
      },
    );
  }

  void _openCitySpecificLink(BuildContext context, int cityId) async {
    final cityLinks = {
      1: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Rödermark&umkreis=15",
      2: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Rodgau&umkreis=15",
      3: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Dietzenbach&umkreis=15",
      4: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Dreieich&umkreis=15",
      5: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Heusenstamm&umkreis=15",
      6: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Mühlheim&umkreis=15",
      7: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Neu%20Isenburg&umkreis=15",
      8: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Obertshausen&umkreis=15",
      9: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Langen&umkreis=15",
      10: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Mainhausen&umkreis=15",
      11: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Egelsbach&umkreis=15",
      12: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Hainburg&umkreis=15",
      13: "https://www.arbeitsagentur.de/jobsuche/suche?angebotsart=1&wo=Seligenstadt&umkreis=15",
    };

    final link = cityLinks[cityId];
    if (link != null) {
      await launchUrl(
        Uri.parse(link),
        mode: LaunchMode.inAppWebView,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Translate.of(context).translate('please_select_city')),
        ),
      );
    }
  }
}
