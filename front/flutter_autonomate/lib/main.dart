import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_page.dart';
import 'SignInPage1.dart';
import 'my_home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  Widget homePage = OnboardingPage1();
  if (seenOnboarding) {
    homePage = isLoggedIn ? AutonomateAppHomeScreen() : AutonomateAppHomeScreen();
  }

  runApp(MyApp(homePage: homePage));
}

class MyApp extends StatelessWidget {
  final Widget homePage;

  const MyApp({Key? key, required this.homePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autonomate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homePage,
    );
  }
}
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
