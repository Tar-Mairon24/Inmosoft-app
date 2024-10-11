import 'package:flutter/material.dart';

class AddPropertyWidget extends StatelessWidget {
  const AddPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 170,
      decoration: BoxDecoration(border: Border.all()),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 50,
              ),
              Text(
                "Agregar propiedad",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
