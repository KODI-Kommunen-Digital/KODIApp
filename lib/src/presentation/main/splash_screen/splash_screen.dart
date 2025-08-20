import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Image.asset(Images.geraLogo),
                  SvgPicture.asset(Images.geraLogoSVG,width: 100,height: 100,),
                ],
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
