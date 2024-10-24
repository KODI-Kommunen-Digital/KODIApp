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
              'Herzlich willkommen in der Gemeinde Schneckenlohe!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '''
 In dieser App finden Sie zahlreiche Informationen über die Gemeinde selbst und das Angebot an kulturellen, sportlichen, kirchlichen sowie gesellschaftlichen Aktivitäten.
 Von Kindergarten bis zur Schulkindsbetreuung, von Gaststätten bis Firmen, Neubaugebiete - unsere Gemeinde hat all das zu bieten, was ein attraktives, gemütliches Wohnumfeld ausmacht. Darüber hinaus bietet unsere unglaublich engagierte Vereinslandschaft ein enorm vielfältiges Freizeitangebot für Jung und Alt – bei uns gibt es noch Gemeinsinn und Engagement!
Herausheben möchte ich besonders unsere Städtepartnerschaft mit Borghetto di Vara in Ligurien, die aktiv gelebt wird. 2023 feiern wir 30-jähriges Partnerschaftsjubiläum. Es sind Freundschaften jeden Alters entstanden, jedes Jahr finden gegenseitige Besuche statt und ein deutsch-italienisches Fest im Juli hat Tradition.
Überzeugen Sie sich selbst und kommen Sie auf einen Besuch in unserer Gemeinde vorbei. Wir heißen Sie herzlich willkommen und freuen uns auf Sie!
''',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
