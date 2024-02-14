import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart';
import 'auth_service.dart';
import 'email_detail_page.dart';

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

    final client = await _authService.signInWithGoogle();
    if (client != null) {
      final gmailApi = GmailApi(client);
      try {
        final messagesResponse = await gmailApi.users.messages.list('me', maxResults: 10); // Limite à 10 emails pour l'exemple
        final List<Message> messages = await Future.wait(messagesResponse.messages!.map((m) async => await gmailApi.users.messages.get('me', m.id!, format: 'metadata', metadataHeaders: ['From', 'Subject'])));
        setState(() {
          _emails = messages;
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
      appBar: AppBar(title: const Text('Your Emails')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _emails.length,
              itemBuilder: (context, index) {
                final email = _emails[index];
                final subject = email.payload!.headers!.firstWhere((header) => header.name == 'Subject').value;
                final from = email.payload!.headers!.firstWhere((header) => header.name == 'From').value;
                return ListTile(
                  title: Text(subject ?? 'No Subject'),
                  subtitle: Text(from ?? 'No Sender'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => EmailDetailPage(emailId: email.id!))),
                );
              },
            ),
    );
  }
}
