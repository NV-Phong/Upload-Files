import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllImages extends StatefulWidget {
  const AllImages({super.key});

  @override
  _AllImagesState createState() => _AllImagesState();
}

class _AllImagesState extends State<AllImages> {
  late Future<List<String>> _imageUrls;

  @override
  void initState() {
    super.initState();
    _imageUrls = fetchImages();
  }

  // Hàm lấy danh sách các URL hình ảnh từ API
  Future<List<String>> fetchImages() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/all-images'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((file) => file['path'] as String).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Images'),
      ),
      body: FutureBuilder<List<String>>(
        future: _imageUrls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No images found'));
          } else {
            final imageUrls = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(imageUrls[index]);
              },
            );
          }
        },
      ),
    );
  }
}
