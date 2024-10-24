import 'package:flutter/material.dart';
import 'package:heidi/src/utils/translate.dart';

class LocalProfileScreen extends StatelessWidget {
  const LocalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('local_profile')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stockheim – lebens- und liebenswert!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '''
Die Gemeinde Stockheim mit ihren sieben Gemeindeteilen liegt in zentraler Lage im Landkreis Kronach inmitten einer außergewöhnlichen Erholungslandschaft. Durch den Anschluss an die Bundesstraßen B85 und B89, einem Bahnhof an der Bahnlinie München-Berlin sowie zahlreichen Buslinien des öffentlichen Nahverkehrs genießen Sie die Vorzüge einer verkehrsgünstigen und naturnahen Lage. 
Die ehemalige Bergwerksgemeinde Stockheim ist eine liebenswerte und lebendige Kommune. Ein Geheimtipp, wenn es darum geht, einmal richtig auszuspannen. Aktivurlaub oder einfach Ruhe, ganz wie Sie es sich wünschen. Wandern, Radfahren, Angeln, Tennis und weitere sportliche Aktivitäten.
Im Jahresverlauf finden zahlreiche Veranstaltungen wie Kirchweihen, Theateraufführungen, Johannifeuer, Maibaumaufstellen oder Büttenabende und Faschingsumzüge statt. Besondere Höhepunkte der Gemeinde Stockheim sind die bergmännisch geprägten Veranstaltungen wie z. B. das Bergmannsfest auf dem ehemaligen Zechengelände oder die bergmännische Weihnacht mit Weihnachtsmarkt und Mettenschicht der Knappen sowie das überörtlich sehr beliebte Weihnachtskonzert der Bergmannskapelle.
Mit der Fertigstellung der Kultur- und Begegnungsstätte RENTEI im ehemaligen Herrenhaus der Zeche „St. Katharina“ im Sommer 2024 wird ein weiterer Anziehungspunkt entstehen, der zum Aufhalten, Genießen und Erleben einlädt. Die RENTEI – modern gepaart mit historischem Charme – bietet verschiedenste Nutzungsmöglichkeiten.
Unser Zusammenleben wollen wir „GemeinschaftlICH“ gestalten. Für uns stehen Kinder und Familien im Mittelpunkt. Die Gemeinde Stockheim bietet durch drei Kindergärten und eine zweizügige Grundschule einen hohen Standard in der Kinderbetreuung und Schulbildung.
Nutzen Sie die Möglichkeiten sich über die Vielfalt der ehrenamtlichen und gemeindlichen Angebote zu informieren. Aber natürlich gilt: Die Herzlichkeit der Menschen, die Ruhe der Natur und den Geschmack unserer kulinarischen Spezialitäten erleben Sie am besten bei uns vor Ort!
''',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
