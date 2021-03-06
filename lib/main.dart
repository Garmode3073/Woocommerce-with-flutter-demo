import 'package:flutter/material.dart';
import 'package:woodemo/pages/login_page.dart';
import 'package:woodemo/pages/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Woocommerce App',
        theme: ThemeData(
          primaryColor: Colors.white,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0,
            foregroundColor: Colors.white,
          ),
          accentColor: Colors.redAccent,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 22,
              color: Colors.redAccent,
            ),
            headline2: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Colors.redAccent,
            ),
            bodyText1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.blueAccent,
            ),
          ),
        ),
        home: LoginPage());
  }
}
