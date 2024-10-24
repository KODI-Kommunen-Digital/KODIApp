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
              'Markt Pressig - Unsere Heimat im Frankenwald!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '''
Der Markt Pressig mit seinen zehn Gemeindeteilen liegt im nördlichen Landkreis Kronach, mitten im wunderschönen Frankenwald. Bürgerschaftliches Engagement prägt das Gemeindeleben und schafft einen hohen Wohn- und Freizeitwert. Hier werden, direkt am Grünen Band und der Bier- und Burgenstraße gelegen, Traditionen gepflegt, pure Lebensfreude und ein modernes Leben gelebt. Über Bus und Bahn ist der Markt Pressig über den öffentlichen Nah- und Fernverkehr unkompliziert zu erreichen.
Unser Gemeindegebiet ist mit rund 61 % von Waldflächen bedeckt. Acker- und Wiesenfluren, Hecken und Feldgehölze bieten hinaus ein abwechslungsreiches Landschaftsbild und erfüllen wichtige ökologische Funktionen.
Pressig selbst verdankt seine Entwicklung in den letzten 130 Jahren der Eisenbahn. Als bedeutender Bahnhof an der Bahnstrecke München-Berlin (Schubbahnhof für die sog. Frankenwaldrampe mit Betriebswerk) war Pressig-Rothenkirchen noch bis zur Deutschen Einheit, u. a. auch als Grenzbahnhof, Haltepunkt für alle Züge.
Bei uns in Pressig gibt es ein breit gefächertes Sport- und Freizeitangebot, herrliche Rad- und Wanderwege, ein idyllisch gelegenes Naturerlebnisbad, Zeltplatz, Beach-Volleyball-Anlage, einen Wohnmobilstellplatz sowie einen Fitness-Parcours. Gespurte Langlaufloipen im Winter und eine intakte Natur bieten alles, was das Herz sich wünscht. Das Freizeitangebot wird durch eine große Vereinsvielfalt erweitert. Engagement und Hilfsbereitschaft sind in den über 100 Vereinen selbstverständlich.
Angefangen bei zwei Kindergärten mit integrierten Kinderkrippen bis hin zur Grund- und Mittelschule, die den mittleren Bildungsabschluss anbietet, hat die Gemeinde alles vor Ort. Auch für die älteren Bürger:innen ist im Alter durch „betreutes Wohnen“, in der Tagespflege sowie in unserm Senioren-Wohnheim eine gute Versorgung garantiert.
Unsere „Juwelen“ sind die kleinen und großen Feste im Laufe des Jahres, sei es die Einhaltkerwa, Rocknacht, Biertouch, Schützenfeste, Faschingsattraktionen … – diese sind einfach kostbar und verbinden Jung und Alt mit Tradition und modernem Leben. Wir laden Sie herzlich dazu ein, den Markt Pressig und die Region Haßlachtal selbst zu erleben und kennenzulernen!
''',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
