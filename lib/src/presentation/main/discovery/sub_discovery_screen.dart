import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/presentation/widget/custom_webview.dart';

class SubDiscoveryScreen extends StatelessWidget {
  final CitizenServiceModel service;

  const SubDiscoveryScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(service.title),
      ),
      body :Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        child:GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent: 300.0,
          ),
          itemCount: service.subServices!.length,
          itemBuilder: (BuildContext context, int index) {
            final item = service.subServices![index];
            return InkWell(
              onTap: () {
                navigateToLink(context,item);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Stack(
                  children: [
                    Image.asset(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> navigateToLink(BuildContext context, CitizenServiceModel service) async {
    String? url;
    switch (service.imageLink) {
      case "17":
        url = 'https://cockpit.gera.de/d/KsIwvw5nz/cockpit?orgId=1&refresh=15m';
        break;
      case "18":
        url = 'https://geoportal.gera.de/portalserver/#/portal/gera';
        break;
      case "19":
        url = 'https://app.spotar.de/gera';
        break;
      case "20":
        url = 'https://www.gvbgera.de/fahrplaene/gvb-liniennetz';
        break;
      case "21":
        url = 'https://www.gvbgera.de/tickets/fahrscheine';
        break;
      case "22":
        break;
      case "23":
        url = 'https://www.gera.de/serviceportal';
        break;
      case "24":
        url = 'https://www.awv-ot.de/App/';
        break;
      case "25":
        break;
    }

    if (url != null) {
      CustomWebViewScreen.showAsBottomSheet(
        context: context,
        title: service.title,
        url: url,
      );
    }
  }
}
