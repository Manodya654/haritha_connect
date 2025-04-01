import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinButton extends StatefulWidget {
  final String? joinLink;
  final String joinButtonText;
  const JoinButton({required this.joinButtonText, required this.joinLink});

  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  bool _linkLoading = false;

  Future<void> _launchURL() async {
    setState(() {
      _linkLoading = true; // Show CircularProgressIndicator
      print("YT Link: ${widget.joinLink}");
    });

    final Uri url = Uri.parse(widget.joinLink ?? "");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to open link!'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _linkLoading = false; // Restore button text after loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          _linkLoading ? null : _launchURL, // Disable button when loading
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: _linkLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(widget.joinButtonText, style: TextStyle(fontSize: 16)),
    );
  }
}
