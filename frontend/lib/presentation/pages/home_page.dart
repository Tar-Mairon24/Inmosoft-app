import 'package:flutter/material.dart';
import 'package:frontend/domain/models/property.dart';
import 'package:frontend/presentation/widgets/add_property_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';
import 'package:frontend/presentation/widgets/property_widget.dart';

class HomePage extends StatelessWidget {
  final List<PropertyWidget> properties;
  const HomePage({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Propiedades',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Filtros"),
                Icon(Icons.filter_alt),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: 56,
                mainAxisSpacing: 32,
                crossAxisCount: 4,
                children: properties,
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}
