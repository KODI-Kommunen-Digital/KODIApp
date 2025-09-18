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
        title: const Text("Stadtwerke Troisdrof"),
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
      case "3":
        url = "https://termin.troisdorf.de/";
        break;
      case "4":
        url = "https://onlinedienste.troisdorf.de/";
        break;
      case "5":
        url = "https://beteiligung.nrw.de/portal/troisdorf/beteiligung/themen?status=AKTUELLE&status=BEENDETE";
        break;
      case "6":
        url = "https://troisdorf.dksr.city/map/";
        break;
      case "7":
        url = "https://web.troisdorf.de/chatbot/";
        break;
      case "8":
        url = "https://onlinedienste.troisdorf.de/detail/-/vr-bis-detail/dienstleistung/524/show";
        break;
      case "9":
        url = "https://troisdorf.dksr.city/poimap/";
        break;
      case "11":
        url = "https://www.troisdorf.de/de/rathaus-service/buergerservice/neubuergerpaket/";
        break;
      case "12":
        url = "https://www.aggua.de/";
        break;
      case "13":
        url = "https://www.stadtwerke-troisdorf.de/";
        break;
      case "14":
        url = "https://www.jeti-line.de/";
        break;
      case "15":
        url = "https://www.troisdorf.de/de/rathaus-service/buergerservice/virtuelles-beratungsbuero/";
        break;
      case "17":
        url = "https://www.rundblick-troisdorf.de/";
        break;
      case "18":
        url = "https://www.trowow.de/";
        break;
      case "19":
        url = "https://www.stadtwerke-troisdorf.de/";
        break;
    }

    if (url != null) {
      CustomWebViewScreen.showAsBottomSheet(
        context: context,
        title: url,
        url: url,
      );
    }
  }

}