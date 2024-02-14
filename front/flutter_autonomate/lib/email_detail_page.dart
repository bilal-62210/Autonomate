import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'auth_service.dart';
import 'package:universal_platform/universal_platform.dart';

class EmailDetailPage extends StatefulWidget {
  final String emailId;

  const EmailDetailPage({Key? key, required this.emailId}) : super(key: key);

  @override
  State<EmailDetailPage> createState() => _EmailDetailPageState();
}

class _EmailDetailPageState extends State<EmailDetailPage> {
  final AuthService _authService = AuthService();
  Message? _email;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      // AndroidWebView ou iOSWebView peut être initialisé ici si nécessaire
    }
    _fetchEmail();
  }

  void _fetchEmail() async {
    setState(() => _isLoading = true);
    final client = await _authService.signInWithGoogle();
    if (client != null) {
      final gmailApi = GmailApi(client);
      try {
        var message = await gmailApi.users.messages.get('me', widget.emailId, format: 'full');
        setState(() {
          _email = message;
          _isLoading = false;
        });
      } catch (e) {
        print('Error retrieving email details: $e');
        setState(() => _isLoading = false);
      } finally {
        client.close();
      }
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Details')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _email == null
              ? const Center(child: Text('Email not found.'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From: ${_getEmailHeaderValue('From')}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Subject: ${_getEmailHeaderValue('Subject')}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        _emailBodyWidget(_email),
                      ],
                    ),
                  ),
                ),
    );
  }

  String _getEmailHeaderValue(String headerName) {
    var header = _email?.payload?.headers?.firstWhere((h) => h.name == headerName, orElse: () => MessagePartHeader(value: "Unknown"));
    return header?.value ?? "Unknown";
  }

  Widget _emailBodyWidget(Message? email) {
    String bodyData = _extractEmailBody(email);
    // Utilisez WebView pour les plateformes mobiles
    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      return WebView(
        initialUrl: Uri.dataFromString(bodyData, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
        javascriptMode: JavascriptMode.unrestricted,
      );
    }
    // Utilisez Html widget pour les autres plateformes
    return Html(data: bodyData);
  }

  String _extractEmailBody(Message? email) {
    if (email == null || email.payload == null) {
      return "Email content not available.";
    }

    String decodeBase64(String base64UrlData) {
      String base64Normalized = base64UrlData.replaceAll('-', '+').replaceAll('_', '/');
      var bytes = base64Decode(base64Normalized);
      return utf8.decode(bytes);
    }

    // Fonction récursive pour chercher dans les parties du message
    String findPartBody(MessagePart? part) {
      // Vérifie si la partie a un corps directement accessible et est de type 'text/html'
      if (part?.mimeType == 'text/html' && part?.body?.data != null) {
        return decodeBase64(part!.body!.data!);
      }
      // Si la partie est de type 'multipart', itérez sur ses sous-parties
      else if (part?.parts != null && part!.parts!.isNotEmpty) {
        for (var subPart in part.parts!) {
          var body = findPartBody(subPart);
          if (body.isNotEmpty) {
            return body; // Retourne le premier 'text/html' trouvé
          }
        }
      }
      // Si aucune partie 'text/html' n'est trouvée, essayez 'text/plain' comme fallback
      else if (part?.mimeType == 'text/plain' && part?.body?.data != null) {
        return decodeBase64(part!.body!.data!);
      }
      return "";
    }

    // Cherchez d'abord dans le corps principal s'il est directement de type 'text/html'
    if (email.payload!.mimeType == 'text/html' && email.payload!.body?.data != null) {
      return decodeBase64(email.payload!.body!.data!);
    }
    // Sinon, utilisez la fonction récursive pour chercher dans les sous-parties
    else {
      var body = findPartBody(email.payload);
      if (body.isNotEmpty) {
        return body;
      }
    }

    // Utilisez le snippet comme dernier recours
    return email.snippet ?? "No content available.";
  }

}
