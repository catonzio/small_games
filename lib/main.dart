import 'package:eight_puzzle/configs/theme.dart';
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
      theme: buildTheme("light"),
      darkTheme: buildTheme("dark"),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
