import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'email_list_page.dart';
import 'package:flutter_autonomate/ui_view/autonomate_app_theme.dart';
import 'package:flutter_autonomate/ui_view/profile_screen.dart';

class MailingPage extends StatefulWidget {
  final bool showAppBar; // Ajouter un indicateur pour afficher ou masquer l'appBar
  const MailingPage({Key? key, this.showAppBar = true}) : super(key: key); // Par défaut, showAppBar est vrai


  @override
  State<MailingPage> createState() => _MailingPageState();
}

class _MailingPageState extends State<MailingPage> {
  final AuthService _authService = AuthService();

  void connectToGmail() async {
    print("Tentative de connexion à Gmail");
    final client = await _authService.signInWithGoogle();
    if (client != null) {
      print("Connecté à Gmail");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmailListPage()),
      );
    } else {
      print("Échec de la connexion à Gmail");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec de la connexion à Gmail")),
      );
    }
  }

  void connectToOutlook() {
    // Implémentez la connexion à Outlook
  }

  void connectToIcloud() {
    // Implémentez la connexion à iCloud Mail
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar ? AppBar(
                  backgroundColor: Colors.transparent, // Fond transparent pour l'AppBar
                  elevation: 0, // Aucune ombre
                  leading: Container(), // Retirer le bouton retour par défaut
                  centerTitle: true,
                  title: Image.asset('../assets/Autonomate_logo.png', height: 50), // Ajuste selon ton logo
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        iconSize: 30, // Ajuster la taille ici
                        icon: Icon(Icons.account_circle, color: AutonomateAppTheme.nearlygrey),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileScreen(), // Assure-toi d'avoir un ProfileScreen
                          ));
                        },
                      ),
                    ),
                  ],
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Fond blanc pour l'AppBar
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ): null,
      backgroundColor: AutonomateAppTheme.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EmailServiceButton(
              serviceName: 'Gmail',
              logoPath: '../assets/gmail_logo1.png', // Assurez-vous du chemin correct
              onTap: connectToGmail,
            ),
            const SizedBox(height: 16),
            EmailServiceButton(
              serviceName: 'Outlook',
              logoPath: '../assets/outlook_logo.png', // Assurez-vous du chemin correct
              onTap: connectToOutlook,
            ),
            const SizedBox(height: 16),
            EmailServiceButton(
              serviceName: 'iCloud Mail',
              logoPath: '../assets/iCloud-Logo.png', // Assurez-vous du chemin correct
              onTap: connectToIcloud,
            ),
          ],
        ),
      ),
    );
  }
}

class EmailServiceButton extends StatelessWidget {
  final String serviceName;
  final String logoPath;
  final VoidCallback onTap;

  const EmailServiceButton({
    Key? key,
    required this.serviceName,
    required this.logoPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.white),
        ),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(logoPath, height: 24),
          const SizedBox(width: 12),
          Text(
            'Connect to $serviceName',
            style: const TextStyle(fontSize: 16, color: AutonomateAppTheme.nearlygrey),
          ),
        ],
      ),
    );
  }
}
