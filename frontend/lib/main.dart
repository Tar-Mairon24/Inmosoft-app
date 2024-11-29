import 'package:flutter/material.dart';
import 'package:frontend/presentation/navigator_key.dart';
import 'package:frontend/presentation/pages/appointments_page.dart';
import 'package:frontend/presentation/pages/detailed_property_page.dart';
import 'package:frontend/presentation/pages/home_page.dart';
import 'package:frontend/presentation/pages/login_page.dart';
import 'package:frontend/presentation/providers/agreements_notifier.dart';
import 'package:frontend/presentation/providers/appointments_notifier.dart';
import 'package:frontend/presentation/providers/auth_provider.dart';
import 'package:frontend/presentation/providers/images_notifier.dart';
import 'package:frontend/presentation/providers/properties_notifier.dart';
import 'package:frontend/presentation/widgets/add_property_widget.dart';
import 'package:frontend/presentation/widgets/agreement_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

List<Widget> properties = [AddPropertyWidget()];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AgreementsNotifier>(
            create: (context) => AgreementsNotifier()),
        ChangeNotifierProvider<ImagesNotifier>(
            create: (context) => ImagesNotifier()),
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<PropertiesNotifier>(
            create: (context) => PropertiesNotifier()),
        ChangeNotifierProvider<AppointmentsNotifier>(
            create: (context) => AppointmentsNotifier()),
      ],
      child: MaterialApp(
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
          switchTheme: SwitchThemeData(
            thumbColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.indigo; // Color del "thumb" cuando está activo
              }
              return Colors.white; // Color del "thumb" cuando está inactivo
            }),
          ),
          popupMenuTheme: PopupMenuThemeData(color: Colors.white),
          drawerTheme: DrawerThemeData(backgroundColor: Colors.indigo[800]),
        ),
        home: LoginPage(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
