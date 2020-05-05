import 'package:credit_cards_animation/constants.dart';
import 'package:credit_cards_animation/src/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Cards',
      debugShowCheckedModeBanner: false,
      color: kWhiteColor,
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      home: HomePage(),
    );
  }
}
