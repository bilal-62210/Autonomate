import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class EmailListPage extends StatefulWidget {
  const EmailListPage({Key? key}) : super(key: key);

  @override
  State<EmailListPage> createState() => _EmailListPageState();
}

class _EmailListPageState extends State<EmailListPage> {
  final AuthService _authService = AuthService();
  List<Message> _emails = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEmails();
  }

  void _fetchEmails() async {
    setState(() {
      _isLoading = true;
    });

    final http.Client? client = await _authService.signInWithGoogle();
    if (client != null) {
      final gmailApi = GmailApi(client);
      try {
        // Récupération des messages
        final ListMessagesResponse messages = await gmailApi.users.messages.list('me');
        setState(() {
          _emails = messages.messages ?? [];
          _isLoading = false;
        });
      } catch (e) {
        print('Erreur lors de la récupération des e-mails: $e');
        setState(() {
          _isLoading = false;
        });
      } finally {
        client.close();
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Emails'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _emails.isEmpty
              ? Center(child: Text("No emails found."))
              : ListView.builder(
                  itemCount: _emails.length,
                  itemBuilder: (context, index) {
                    // Affichage simplifié pour le moment
                    return ListTile(
                      title: Text('Email ${index + 1}'),
                      subtitle: Text(_emails[index].id ?? 'No ID'), // Correction appliquée ici
                      onTap: () {
                        // Option pour ouvrir ou afficher plus de détails sur l'e-mail
                      },
                    );
                  },
                ),
    );
  }
}
