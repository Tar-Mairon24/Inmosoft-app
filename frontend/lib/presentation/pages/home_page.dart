import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/add_property_widget.dart';
import 'package:frontend/presentation/widgets/navigation_drawer_widget.dart';
import 'package:frontend/presentation/widgets/property_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              children: [Text("Filtros"), Icon(Icons.filter_alt)],
            ),
            Column(
              children: [
                Row(
                  children: [
                    AddPropertyWidget(),
                    SizedBox(
                      width: 40,
                    ),
                    PropertyWidget()
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}
