import 'package:flutter/material.dart';

import '../../utils/translate.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text(
        Translate.of(context).translate("this_feature_will_be_available_soon"),
      )),
    );
  }
}
