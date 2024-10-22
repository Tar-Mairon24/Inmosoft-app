import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/agreement_adder_page.dart';
import 'package:frontend/presentation/pages/login_page.dart';
import 'package:frontend/presentation/pages/agreements_page.dart';
import 'package:frontend/presentation/pages/property_adder_page.dart';
import 'package:frontend/presentation/widgets/add_property_widget.dart';
import 'package:frontend/presentation/widgets/property_widget.dart';

void main() {
  runApp(MyApp());
}

List<Widget> properties = [AddPropertyWidget()];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      PropertyWidget property = PropertyWidget(
          image: Image.asset('assets/images/images.jpeg'),
          title: 'Casa $i',
          status: 'Disponible',
          price: i.toDouble());
      properties.add(property);
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'InmoSoft',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white,
          primaryTextTheme: TextTheme(
            titleLarge: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
            labelMedium: TextStyle(color: Colors.grey[600], fontSize: 12),
            bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
            bodySmall: TextStyle(color: Colors.black, fontSize: 12),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ),
          popupMenuTheme: PopupMenuThemeData(color: Colors.white),
          drawerTheme: DrawerThemeData(backgroundColor: Colors.indigo[800]),
        ),
        home: AgreementsPage());
  }
}
