import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigo[700],
      child: Center(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );

  Widget buildMenuItems(BuildContext context) => Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            title: const Text(
              'Citas',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'Contratos',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
        ],
      );
}
