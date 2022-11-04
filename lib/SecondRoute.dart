import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Sign-out'),
        ),
      ),
    );
  }
}
