import 'package:flutter/material.dart';
import 'presentation/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InmoSoft',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        primaryTextTheme: TextTheme(
          titleMedium: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          labelMedium: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
