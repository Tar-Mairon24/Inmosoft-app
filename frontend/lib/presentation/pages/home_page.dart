import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String email;

  const HomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $email!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add any action you want to perform on button press
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
