import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'email_list_page.dart';

class MailingPage extends StatefulWidget {
  const MailingPage({Key? key}) : super(key: key);

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
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('../assets/icon1.png', height: 40), // Assurez-vous du chemin correct
        backgroundColor: Colors.grey[150],
        foregroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.grey[50],
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
        primary: Colors.white,
        onPrimary: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.grey[300]!),
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
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
