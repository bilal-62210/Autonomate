import 'package:flutter/material.dart';
import 'package:flutter_autonomate/ui_view/autonomate_app_theme.dart';

class test extends StatelessWidget {
  final AnimationController? animationController;

  const test({Key? key, this.animationController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AutonomateAppTheme.lightTheme, // Utilise le thème personnalisé
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Home Page'),
        ),
        body: Center(
          child: Text('Contenu de MyHomePage'),
        ),
      ),
    );
  }
}
