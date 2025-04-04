import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  final List<String> _images = [
  // 'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg',
  // 'https://images.pexels.com/photos/1464720/pexels-photo-1464720.jpeg',
  // 'https://images.pexels.com/photos/34950/pexels-photo.jpg',
  // Add more image URLs
];

  void _search(String query) {
    setState(() {
      _searchResults = _images
          .where((image) => image.contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: _searchResults.isEmpty ? _images.length : _searchResults.length,
          itemBuilder: (context, index) {
            return Image.network(
              _searchResults.isEmpty ? _images[index] : _searchResults[index],
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}