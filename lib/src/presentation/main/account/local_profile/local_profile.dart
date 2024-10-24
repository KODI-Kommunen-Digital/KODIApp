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
              'Herzlich willkommen in Mitwitz!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '''
Unsere Marktgemeinde mit ihren neun Ortsteilen und den zahlreichen Wustungen ist eingebettet in das idyllische Föritz- und Steinachtal, umgeben von den Ausläufern des Frankenwalds mit Aussichten bis in den Thüringer Wald. Wir gelten als „Tor zum Frankenwald" und als Wiege des Grünen Bandes. Weithin bekannt ist unser romantisches Wasserschloss. Es begeistert nicht nur Gäste, auch wir Mitwitzer Bürgerinnen und Bürger lieben unser Aushängeschild. In den historischen Räumen feiern wir Hochzeiten und besuchen Konzerte. Im Schlosspark ist das ganze Jahr über etwas los: Fränkisches Gartenfest, Schlossparkfest, musikalisches Picknick, rock-sinfonisches Open-Air und zum Jahresabschluss die stimmungsvolle Mitwitzer Schlossweihnacht. Kommen Sie gerne dazu!
''',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
