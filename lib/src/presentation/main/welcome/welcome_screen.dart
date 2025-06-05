import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/main/login/signin/signin_screen.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
        pages: [
          PageViewModel(
            title: "Title of introduction page",
            body: "Welcome to the app! This is a description of how it works.",
            image: const Center(
              child: Icon(Icons.waving_hand, size: 50.0),
            ),
          ),
          PageViewModel(
            title: "Title of introduction page",
            body: "Welcome to the app! This is a description of how it works.",
            image: const Center(
              child: Icon(Icons.waving_hand, size: 50.0),
            ),
          ),
          PageViewModel(
            title: "Title of introduction page",
            body: "Welcome to the app! This is a description of how it works.",
            image: const Center(
              child: Icon(Icons.waving_hand, size: 50.0),
            ),
          ),
        ],
        showNextButton: false,
        done: const Text("Done"),
        onDone: () {
          // On button pressed
        },
      )),
    );
  }

  void naviagateToLoginPage() async {
    final result = await Navigator.pushNamed(context, Routes.signIn);

    if (!mounted) return;
    if (result != null && result == SignInScreen.loginSuccessResult) {
      Navigator.pop(context);
    }
  }
}
