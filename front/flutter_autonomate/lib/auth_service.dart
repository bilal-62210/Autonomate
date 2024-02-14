import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/gmail/v1.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Assurez-vous de remplacer clientId si vous utilisez GoogleSignIn pour le web
    clientId: '512923324945-siecu9m3noempaov9plimneenbgsvm4i.apps.googleusercontent.com',
    scopes: ['https://www.googleapis.com/auth/gmail.readonly'],
  );

  Future<http.Client?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        print("Google sign in was aborted");
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await account.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authHeaders = await _googleSignIn.currentUser!.authHeaders;

        // Création d'un client HTTP authentifié pour l'API Gmail
        final httpClient = GoogleAuthClient(authHeaders);

        return httpClient;
      } else {
        print("Missing Google auth token");
        return null;
      }
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}

// Classe helper pour créer un client HTTP qui inclut les en-têtes d'autorisation pour chaque requête
class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }

  @override
  void close() {
    _client.close();
  }
}
