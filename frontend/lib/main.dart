// lib/main.dart

import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart'; // Import the LoginPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(), // Set LoginPage as the home page
    );
  }
}
