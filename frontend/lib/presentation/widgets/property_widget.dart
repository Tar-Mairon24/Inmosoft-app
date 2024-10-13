import 'package:flutter/material.dart';

class PropertyWidget extends StatelessWidget {
  final Image image;
  final String title;
  final String status;
  final double price;
  const PropertyWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.status,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 170,
      decoration: BoxDecoration(border: Border.all(), color: Colors.grey),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: image),
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
                          title,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          status,
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "$price MXN",
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
