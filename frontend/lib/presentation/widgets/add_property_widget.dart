import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/property_adder_page.dart';

class AddPropertyWidget extends StatelessWidget {
  const AddPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Theme.of(context).iconTheme.color,
                  size: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  "Agregar propiedad",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PropertyAdderPage()),
      ),
    );
  }
}
