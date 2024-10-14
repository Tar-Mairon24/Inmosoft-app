// lib/main.dart

import 'package:flutter/material.dart';
import 'presentation/pages/login_page.dart'; // Import the LoginPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.indigo,
      ),
      home: LoginPage(), // Set LoginPage as the home page
    );
  }
}
