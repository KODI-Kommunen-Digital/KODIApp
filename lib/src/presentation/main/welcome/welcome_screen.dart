import 'package:flutter/material.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../../utils/configs/image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  bool verifyTerms = false;
  bool getPushNots = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: IntroductionScreen(
        key: _introKey,
        pages: [
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                SvgPicture.asset(Images.geraLogoSVG,height: 100,width: 100,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleLarge,
                    children: [
                      const TextSpan(
                          text: "Ob auf Reisen oder zu Hause, Ihr "),
                      const TextSpan(
                        text: "Gera-",
                        style: TextStyle(color: Colors.red),
                      ),
                      TextSpan(
                        text: "Gefühl",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      const TextSpan(
                        text:
                            " beginnt genau hier - personalisiert und voller Inspiration.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                AppButton(Translate.of(context).translate('proceed'),
                    color: Colors.red, onPressed: () {
                  nextPageView();
                })
              ],
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                SvgPicture.asset(Images.geraLogoSVG,height: 100,width: 100,),
                Text(
                  "Registrieren Sie sich mit einem eigenen Profil und nutzen Sie weitere Vorteile, wie Lieblingsbeiträge zu favorisieren oder mit Ihren Liebsten zu teilen!",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 48,
                ),
                InkWell(
                  onTap: () {
                    navigateToRegisterPage();
                  },
                  child: Container(
                    height: screenHeight / 15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        )),
                    child: Center(
                        child: Text(
                            Translate.of(context).translate('go_to_register'))),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    navigateToLoginPage();
                  },
                  child: Container(
                    height: screenHeight / 15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        )),
                    child: Center(
                      child:
                          Text(Translate.of(context).translate('go_to_login')),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                AppButton(Translate.of(context).translate('skip'),
                    color: Colors.red, onPressed: () {
                  nextPageView();
                })
              ],
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                SvgPicture.asset(Images.geraLogoSVG,height: 100,width: 100,),
                Text(
                  "Die Gera-App sendet Ihnen Benachrichtigungen über Veranstaltungen in Ihrer Umgebung, Updates zu Ihren kommunalen Anträgen und Erinnerungen, wenn es Zeit ist, den Müll herauszubringen.\n Bitte bestätigen Sie, dass Sie mit dem Erhalt solcher Push-Benachrichtigungen einverstanden sind.",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 48,
                ),
                Container(
                  height: screenHeight / 15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                                (getPushNots)
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: screenHeight / 20),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                getPushNots = !getPushNots;
                                //TODO: sign up to push nots in firebase
                              });
                            },
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Expanded(
                              child: Text(
                            "Ich möchte bei für mich wichtigen Infos benachrichtigt werden.",
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                AppButton(Translate.of(context).translate('proceed'),
                    color: Colors.red, onPressed: () {
                  nextPageView();
                })
              ],
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                SvgPicture.asset(Images.geraLogoSVG,height: 100,width: 100,),
                Text(
                  "Bevor Sie beginnen, akzeptieren Sie bitte unsere Nutzungsbedingungen. Leider können Sie die Gera-App ohne Ihre Zustimmung nicht nutzen.",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 48,
                ),
                InkWell(
                  onTap: () {
                    //TODO: NAvigate to terms of use
                  },
                  child: Container(
                    height: screenHeight / 15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.red,
                              size: screenHeight / 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(Translate.of(context)
                                  .translate('view_terms_of_use')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: screenHeight / 15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                                (verifyTerms)
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: screenHeight / 20),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                verifyTerms = !verifyTerms;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(Translate.of(context)
                                .translate('verify_terms_of_use')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        showNextButton: false,
        done: Text(Translate.of(context).translate('done')),
        onDone: () {
          _onDone();
        },
        globalFooter: Container(
          color: Colors.white, // set background color
          child: Image.asset(Images.skyline),
        ),
      )),
    );
  }

  void _onDone() async {
    if (verifyTerms != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Translate.of(context).translate("must_verify_terms_of_use"),
          ),
        ),
      );
    } else {
      final prefs = await Preferences.openBox();
      await prefs.setBool('hasOpenedAppBefore', true);
      Navigator.pop(context);
    }
  }

  void navigateToLoginPage() async {
    final result = await Navigator.pushNamed(context, Routes.signIn);

    if (!mounted) return;
    final userId = await UserRepository.getLoggedUserId();
    if (userId != 0) {
      nextPageView();
    }
  }

  void navigateToRegisterPage() async {
    final result = await Navigator.pushNamed(context, Routes.signUp);

    if (!mounted) return;
    final userId = await UserRepository.getLoggedUserId();
    if (userId != 0) {
      nextPageView();
    }
  }

  void nextPageView() {
    _introKey.currentState?.next();
  }
}
