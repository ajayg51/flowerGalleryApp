import 'package:flower_gallery/flower_gallery_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ajay's Flower Gallery",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey,
        useMaterial3: true,
      ),
      home: FlowerGalleryPage(),
    );
  }
}
