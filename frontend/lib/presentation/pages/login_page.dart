import 'package:flutter/material.dart';
import '../../services/login_service.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DioService dioService = DioService();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double separation = MediaQuery.of(context).size.height * 0.04;

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
                    style: Theme.of(context).primaryTextTheme.titleMedium,
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
                            labelText: 'tu email',
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
                            labelText: 'tu contraseña',
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                bool success = await dioService.login(
                                  emailController.text,
                                  passwordController.text,
                                );

                                if (success) {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         HomePage(),
                                  //   ),
                                  // );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Text(
                                          "Credenciales no válidas, inténtelo de nuevo."),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("OK"))
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            style: Theme.of(context).filledButtonTheme.style,
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
