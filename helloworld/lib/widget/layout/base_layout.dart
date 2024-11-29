import 'package:flutter/material.dart';
import 'package:helloworld/widget/layout/navigationbar.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Engineer'),
      ),
      body: body, // Nội dung của mỗi trang
      bottomNavigationBar: NavigationExample(), // Navigation bar
    );
  }
}
