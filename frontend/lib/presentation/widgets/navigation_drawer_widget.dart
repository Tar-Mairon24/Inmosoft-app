import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/agreements_page.dart';
import 'package:frontend/presentation/pages/appointments_page.dart';
import 'package:frontend/presentation/pages/home_page.dart';
import 'package:frontend/presentation/pages/login_page.dart';
import 'package:frontend/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Wrap(
            runSpacing: MediaQuery.of(context).size.height * 0.04,
            children: [
              UserAccountsDrawerHeader(
                accountName: null,
                accountEmail: Text(
                  authProvider.userId!,
                ),
                decoration: BoxDecoration(color: Colors.grey[400]),
              ),
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text(
                  'Inicio',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage())),
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_month_outlined,
                ),
                title: Text(
                  'Citas',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const AppointmentsPage())),
              ),
              ListTile(
                leading: Icon(Icons.description_outlined),
                title: Text(
                  'Contratos',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const AgreementsPage())),
              ),
              ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text(
                    'Cerrar sesión',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: const Text(
                            "¿Está seguro de que desea cerrar la sesión?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              authProvider.logout();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: const Text("SI"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("NO"),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ],
      )),
    );
  }
}
