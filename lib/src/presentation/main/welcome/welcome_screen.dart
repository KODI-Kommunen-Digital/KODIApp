import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/main/login/signin/signin_screen.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/routes.dart';

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
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  children: [
                    const Text(
                      'Willkommen bei',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Image.asset(
                      Images.logo,
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Erleben Sie die App in ihrer \nbesten Form!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Melde Dich direkt an und lege Deine\npersönlichen Favoriten fest.\nSo fokussierst Du Dich auf\nLieblingsrestaurants und vieles mehr\nund hast optimalen Zugriff auf Deine Interessen.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.018,
                          ),
                        ),
                        onPressed: () {
                          naviagateToLoginPage();
                        },
                        child: Text(
                          'Anmelden',
                          style: TextStyle(fontSize: screenWidth * 0.045),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.018,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.signUp);
                        },
                        child: Text(
                          'Registrieren',
                          style: TextStyle(fontSize: screenWidth * 0.045),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.home);
                      },
                      child: Text(
                        'Ohne Anmeldung fortfahren',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
