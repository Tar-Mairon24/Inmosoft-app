import 'package:flutter/material.dart';

class AgreementWidget extends StatelessWidget {
  const AgreementWidget(
      {super.key,
      required this.type,
      required this.title,
      required this.property,
      required this.client});
  final String type;
  final String title;
  final String property;
  final String client;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(), // Borde recto
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.04),
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(
            title,
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          subtitle: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinear a la izquierda
            children: [
              Text(
                property,
              ),
              Text(client),
            ],
          ),
          trailing: Icon(Icons.more_vert_outlined),
        ),
      ),
    );
  }
}
