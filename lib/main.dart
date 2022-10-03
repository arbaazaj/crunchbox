import 'package:crunchbox/pages/homepage.dart';
import 'package:crunchbox/themes/themes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crunch Box',
      theme: buildShrineTheme(),
      home: HomePage(title: 'Crunch Box'),
    );
  }
}