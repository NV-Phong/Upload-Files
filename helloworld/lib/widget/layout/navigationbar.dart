import 'package:flutter/material.dart';
import 'package:helloworld/screens/all_images_screen.dart';
import 'package:helloworld/screens/upload_image_screen.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  // Các trang ứng với từng tab
  final List<Widget> pages = [
    const AllImages(), // Trang Home
    const UploadImageScreen(), // Trang Upload Image
    Center(child: Text('Messages Page')), // Trang Messages
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Show All Image',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Upload Image',
          ),
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
        ],
      ),
    );
  }
}
