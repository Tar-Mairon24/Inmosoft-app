import 'package:flutter/material.dart';
import '../../services/login_service.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DioService dioService = DioService();
  final String? errorMessage = '';

  LoginPage({super.key}); // Instantiate the Dio service

  void _login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    final result = await dioService.login(email, password);

    if (result.success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(email: email),
        ),
      );
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
                                _login(context);
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
