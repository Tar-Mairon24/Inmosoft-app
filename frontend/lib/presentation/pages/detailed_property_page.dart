import 'package:flutter/material.dart';

class DetailedPropertyPage extends StatelessWidget {
  const DetailedPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.aspectRatio * 14),
        child: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Image.asset(
                  'assets/images/images2.jpg',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          child: Text('Ficha técnica'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          child: Text('Generar publicidad'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.08,
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  'Casa en V. Carranza',
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
