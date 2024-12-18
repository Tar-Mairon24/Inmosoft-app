import 'package:flutter/material.dart';
import 'package:frontend/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../services/login_service.dart';
import '../../services/propiedad_service.dart';
import '../widgets/property_widget.dart';
import '../../domain/models/propiedad_menu_modelo.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService dioService = LoginService();
  final PropiedadService propiedadService = PropiedadService();
  final String? errorMessage = '';

  LoginPage({super.key}); // Instantiate the Dio service

  // List<Widget> crearPropiedades(List<PropiedadMenu> propiedades) {
  //   List<Widget> widgets = [
  //     AddPropertyWidget(), // El primer elemento de la lista
  //     ...propiedades.map((propiedad) {
  //       return PropertyWidget(
  //         image: Image.asset('assets/images/images.jpeg'),
  //         title: propiedad.titulo,
  //         status: propiedad.estado,
  //         price: propiedad.precio,
  //       );
  //     }),
  //   ];
  //   return widgets;
  // }

  void _login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    final result = await dioService.login(email, password);

    if (result.success) {
      final resultPropiedades = await propiedadService.getAllPropiedades();
      if (resultPropiedades.success) {
        // final propiedades = resultPropiedades.data;
        // final propiedadesWidget = crearPropiedades(propiedades ?? []);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              resultPropiedades.errorMessage ??
                  'Checar la conexion con el servidor',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              )
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            result.errorMessage ?? 'Checar la conexion con el servidor',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double separation = MediaQuery.of(context).size.height * 0.04;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bienvenido a InmoSoft",
                    style: Theme.of(context).primaryTextTheme.titleLarge,
                  ),
                  SizedBox(height: separation * 2),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelStyle:
                                Theme.of(context).primaryTextTheme.labelMedium,
                            labelText: 'email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: separation,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelStyle:
                                Theme.of(context).primaryTextTheme.labelMedium,
                            labelText: 'contraseña',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: separation),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _login(context);
                                authProvider.login(emailController.text);
                              }
                            },
                            child: Text(
                              'Ingresar',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
