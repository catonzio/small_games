import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eight Puzzle',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          background: Color(0xFF030811),
          surface: Color(0xFF26292A),
          primary: Color.fromARGB(255, 33, 188, 240),
          secondary: Color(0xFF26292A),
          onBackground: Colors.white, // const Color(0xFF26292A),
          onSurface: Colors.white, // const Color(0xFF26292A),
          onPrimary: Colors.white, // const Color(0xFF26292A),
          onSecondary: Colors.white, // const Color(0xFF26292A),
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
