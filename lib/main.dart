import 'package:crunchbox/pages/homepage.dart';
import 'package:crunchbox/pages/login.dart';
import 'package:crunchbox/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crunch Box',
      theme: buildShrineTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/loginPage', page: () => LoginPage()),
      ],
      home: HomePage(title: 'Crunch Box'),
    );
  }
}