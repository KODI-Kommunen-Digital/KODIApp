import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logo = isDarkMode ? Images.logo_dark : Images.logo_light;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: backgroundColor,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: Image.asset(logo),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 300),
              child: SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
