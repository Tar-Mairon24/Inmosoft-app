// lib/main.dart

import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/home_page.dart';
import 'package:frontend/presentation/widgets/property_widget.dart';
import 'presentation/pages/login_page.dart'; // Import the LoginPage

void main() {
  runApp(MyApp());
}

List<PropertyWidget> properties = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      PropertyWidget property = PropertyWidget(
          image: Image.asset('../assets/images/images.jpeg'),
          title: 'Casa $i',
          status: 'Disponible',
          price: i.toDouble());
      properties.add(property);
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(
        properties: properties,
      ), // Set LoginPage as the home page
    );
  }
}
