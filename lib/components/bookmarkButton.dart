import 'package:flutter/material.dart';

class BookmarkButton extends StatefulWidget {
  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool _isBookmarked = false; // Keeps track of the state

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_border, // Toggle between the two icons
        color: Colors.blue,
        size: 25.5,
      ),
      onPressed: () {
        setState(() {
          _isBookmarked = !_isBookmarked; // Change the state when clicked
        });
      },
    );
  }
}
