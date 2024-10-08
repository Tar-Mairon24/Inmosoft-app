// lib/main.dart

import 'package:flutter/material.dart';
import 'pages/login_page.dart'; // Import the LoginPage

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
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Set LoginPage as the home page
    );
  }
}