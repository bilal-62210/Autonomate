import 'package:flutter/material.dart';
import 'package:flutter_autonomate/my_home_page.dart';
import 'package:flutter_autonomate/ui_view/autonomate_app_theme.dart';

class SignInPage1 extends StatefulWidget {
  const SignInPage1({Key? key}) : super(key: key);

  @override
  State<SignInPage1> createState() => _SignInPage1State();
}

class _SignInPage1State extends State<SignInPage1> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isSignUp = false; // Ajouté pour basculer entre inscription et connexion

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              constraints: const BoxConstraints(maxWidth: 350),
              color: AutonomateAppTheme.background,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('../assets/icon1.png', height: 100), // Assure-toi que le chemin est correct
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        "Bienvenue sur Autonomate",
                        style: Theme.of(context).textTheme.headline5!.copyWith(color: AutonomateAppTheme.darkerText),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Entrez votre adresse email et votre mot de passe pour continuer.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AutonomateAppTheme.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    _emailFormField(),
                    const SizedBox(height: 16),
                    _passwordFormField(),
                    const SizedBox(height: 16),
                    _rememberMeCheckbox(),
                    const SizedBox(height: 16),
                    _signInButton(),
                    const SizedBox(height: 16),
                    _toggleSignUpSignInButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
Widget _emailFormField() {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Merci d'entrer du texte";
      }

      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (!emailValid) {
        return "Merci de saisir une email valide";
      }

      return null;
    },
    decoration: const InputDecoration(
      labelText: 'Email',
      hintText: 'Saisir votre email',
      prefixIcon: Icon(Icons.email_outlined),
      border: OutlineInputBorder(),
    ),
  );
}


 Widget _passwordFormField() {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Merci d'entrer du texte";
      }

      if (value.length < 6) {
        return "Le mot de passe doit contenir au moins 6 caractères";
      }
      return null;
    },
    obscureText: !_isPasswordVisible,
    decoration: InputDecoration(
      labelText: 'Mot de passe',
      hintText: 'Saisir votre mot de passe',
      prefixIcon: const Icon(Icons.lock_outline_rounded),
      border: const OutlineInputBorder(),
      suffixIcon: IconButton(
        icon: Icon(_isPasswordVisible
            ? Icons.visibility_off
            : Icons.visibility),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      ),
    ),
  );
}


  Widget _rememberMeCheckbox() {
  return CheckboxListTile(
    value: _rememberMe,
    onChanged: (value) {
      setState(() {
        _rememberMe = value!;
      });
    },
    title: const Text('Se souvenir de moi'),
    controlAffinity: ListTileControlAffinity.leading,
    dense: true,
    contentPadding: const EdgeInsets.all(0),
  );
}


  Widget _signInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AutonomateAppTheme.nearlyBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            _isSignUp ? 'Inscription' : 'Connexion',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Logique de connexion
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AutonomateAppHomeScreen(),
            ));
          }
        },
      ),
    );
  }

void _registerUser() {
  // Implémentez la logique pour l'inscription ici
}

void _loginUser() {
  // Implémentez la logique pour la connexion ici
}


  Widget _toggleSignUpSignInButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _isSignUp = !_isSignUp;
        });
      },
      child: Text(
        _isSignUp ? 'Déjà inscrit ? Connectez-vous' : 'Pas encore inscrit ? Inscrivez-vous',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AutonomateAppTheme.grey),
      ),
    );
  }
}
