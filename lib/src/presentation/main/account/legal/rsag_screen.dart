import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RsagScreen extends StatelessWidget {
  const RsagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://www.rsag.de/service/rsag-app');

    return Scaffold(
      appBar: AppBar(
        title: const Text('RSAG-App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Die kostenlose RSAG-App ist die digitale Entsorgungs-Hilfe für die Hosentasche und enthält alle wichtigen Informationen rund um die Themen Abfall, Entsorgungsmöglichkeiten und Abfuhrtermine im Rhein-Sieg-Kreis. Weitere Informationen finden Sie unter ',
                style: TextStyle(fontSize: 18.0)),
            GestureDetector(
              onTap: () => _launchURL(url),
              child: const Text(
                'https://www.rsag.de/service/rsag-app.',
                style: TextStyle(color: Colors.blue, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
