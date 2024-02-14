import 'package:flutter/material.dart';
import 'package:flutter_autonomate/ui_view/autonomate_app_theme.dart'; // Assure-toi que le chemin est correct

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Profil"),
        backgroundColor: AutonomateAppTheme.nearlyBlue, // Utilise ta couleur de thème ici
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://via.placeholder.com/150"), // Remplace par l'image de profil
                radius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Nom de l'utilisateur",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                "Ici, tu peux ajouter plus d'informations sur l'utilisateur, comme son email, une bio, etc.",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Ici, tu peux ajouter une action pour éditer le profil par exemple
                },
                child: Text('Éditer le Profil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
