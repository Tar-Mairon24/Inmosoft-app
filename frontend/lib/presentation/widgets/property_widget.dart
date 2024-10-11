import 'package:flutter/material.dart';

class PropertyWidget extends StatelessWidget {
  const PropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 180,
      decoration: BoxDecoration(border: Border.all(), color: Colors.grey),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                "../../assets/images/images.jpeg",
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Casa Ramos",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Vendida",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "1 150 000 MXN",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Icon(Icons.more_vert_outlined),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
