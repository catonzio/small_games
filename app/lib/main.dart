import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:small_games/config/themes.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SmallGames",
      theme: Themes.getTheme(),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.system,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
