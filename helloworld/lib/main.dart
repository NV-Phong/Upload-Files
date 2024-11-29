import 'package:flutter/material.dart';
import 'package:helloworld/routes/home_route.dart';

Future<void> main() async {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Engineer',
      initialRoute: '/', // Route ban đầu
      routes: {
        ...HomeRoutes.routes, // Gộp routes từ HomeRoutes
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Route không tồn tại!')),
        ),
      ),
    );
  }
}
