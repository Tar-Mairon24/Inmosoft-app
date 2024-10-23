import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/agreements_page.dart';
import 'package:frontend/presentation/pages/appointments_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
        runSpacing: MediaQuery.of(context).size.height * 0.04,
        children: [
          ListTile(
            title: Text(
              'Inicio',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Divider(
              color: Colors.white,
            ),
          ),
          ListTile(
            title: Text(
              'Citas',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const AppointmentsPage())),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Divider(
              color: Colors.white,
            ),
          ),
          ListTile(
            title: Text(
              'Contratos',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const AgreementsPage())),
          ),
        ],
      );
}
