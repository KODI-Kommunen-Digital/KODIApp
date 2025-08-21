import 'package:flutter/material.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:introduction_screen/introduction_screen.dart';

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
                Text(
                  "GERA",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 90),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleLarge,
                    children: [
                      const TextSpan(
                          text: "Willkommen in deiner Gera City-App!\n"),
                      const TextSpan(
                          text: "Die Stadt in deiner Tasche – hier beginnt dein "),
                      const TextSpan(
                        text: "Gera-",
                        style: TextStyle(color: Colors.red),
                      ),
                      TextSpan(
                        text: "Gefühl:",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      const TextSpan(
                        text:
                            " persönlich, aktuell und voller Inspiration.",
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
                Text(
                  "GERA",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 90),
                ),
                Text(
                  "Registriere dich und sichere dir noch mehr Vorteile:",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "• Eigene Veranstaltungen speichern",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "•  Push-Benachrichtigungen zu deinen zugeschnittenen Inhalten",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Und viel mehr!",
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
                Text(
                  "GERA",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 90),
                ),
                Text(
                  "Bleib immer auf dem Laufenden!",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Die App informiert dich über:",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "• Veranstaltungen (in deiner Nähe)",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "• Updates zu deinen Anträgen (später, da dies noch nicht als Funktion vorhanden ist)",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "• Erinnerungen zur Müllabfuhr",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "• Aktuelle Pressemitteilungen",
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
                            "Bitte bestätige, dass du Push-Benachrichtigungen erhalten möchtest.",
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
                Text(
                  "GERA",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 90),
                ),
                Text(
                  "Bevor es losgeht",
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
