import 'package:flutter/material.dart';

class AddPropertyWidget extends StatelessWidget {
  const AddPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  "Agregar propiedad",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
