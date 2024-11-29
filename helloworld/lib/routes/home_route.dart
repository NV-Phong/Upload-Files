import 'package:flutter/material.dart';
import 'package:helloworld/screens/all_images_screen.dart';
import 'package:helloworld/screens/upload_image_screen.dart';
import 'package:helloworld/widget/layout/base_layout.dart';

class HomeRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const BaseLayout(body: AllImages()),
    '/upload-image': (context) => const BaseLayout(body: UploadImageScreen()),
  };
}
