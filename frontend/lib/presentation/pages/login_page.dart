import 'package:flutter/material.dart';
import '../../services/login_service.dart'; // Import the Dio service
import 'home_page.dart';

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
            result.errorMessage ?? 'Credenciales no válidas, inténtelo de nuevo.',
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
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bienvenido a InmoSoft",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
              ),
              SizedBox(height: 64),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "correo electrónico",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 12),
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
                    SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "contraseña",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 12),
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
                    SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _login(context);
                          }
                        },
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.indigo[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0))),
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(fontSize: 12),
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
    );
  }
}
