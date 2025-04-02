import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmailScreen(),
    );
  }
}

class EmailScreen extends StatelessWidget {
  final String user2Email = "user2@example.com"; //replace

  void openOutlook(String email) async {
    final Uri outlookUri = Uri.parse(
        "https://outlook.office.com/mail/deeplink/compose?to=$email");

    if (await canLaunchUrl(outlookUri)) {
      await launchUrl(outlookUri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not open Outlook");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email User")),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.email, size: 50, color: Colors.blue),
          onPressed: () => openOutlook(user2Email),
        ),
      ),
    );
  }
}
