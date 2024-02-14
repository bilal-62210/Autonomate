import 'package:flutter/material.dart';
import 'main.dart';

class SignInPage1 extends StatefulWidget {
  const SignInPage1({Key? key}) : super(key: key);

  @override
  State<SignInPage1> createState() => _SignInPage1State();
}

class _SignInPage1State extends State<SignInPage1> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isSignUp = true; // Ajouté pour basculer entre inscription et connexion

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
              color: Colors.grey[200], // Fond gris clair
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('../assets/icon1.png', height: 100), // Logo personnalisé
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        "Bienvenue sur Autonomate",
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.grey[800]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Entrez votre adresse email et votre mot de passe pour continuer.",
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _gap(),
                    _emailFormField(),
                    _gap(),
                    _passwordFormField(),
                    _gap(),
                    _rememberMeCheckbox(),
                    _gap(),
                    _signInButton(),
                    _gap(),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          _isSignUp ? 'Inscription' : 'Connexion',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // Ici, vous pouvez intégrer la logique pour la connexion ou l'inscription
          // Par exemple, vous pouvez appeler une fonction pour se connecter à votre backend
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainPage(),
          ));
          if (_isSignUp) {
            // Logique pour l'inscription
            _registerUser();
          } else {
            // Logique pour la connexion
            _loginUser();
          }
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
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
