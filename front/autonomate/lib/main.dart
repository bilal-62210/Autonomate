import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_page.dart';
import 'my_home_page.dart';
import 'mailing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(home: CircularProgressIndicator());
        }
        final prefs = snapshot.data;
        final bool seenOnboarding = prefs?.getBool('seenOnboarding') ?? false;

        return MaterialApp(
          title: 'Autonomate',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
            useMaterial3: true,
          ),
          home: seenOnboarding ? const MainPage() : const OnboardingPage1(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const MyHomePage(),
    const MailingPage(),
    // Vous pouvez ajouter d'autres pages ici
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ), // Utilisez IndexedStack pour maintenir l'état des pages
      bottomNavigationBar: BottomNavigationBar(
        items : const [
BottomNavigationBarItem(
icon: Icon(Icons.home),
label: 'Home',
),
BottomNavigationBarItem(
icon: Icon(Icons.mail),
label: 'Mail',
),
// Ajoutez d'autres BottomNavigationBarItem ici selon vos besoins
],
currentIndex: _selectedIndex,
selectedItemColor: Colors.blueGrey,
onTap: _onItemTapped,
),
);
}
}