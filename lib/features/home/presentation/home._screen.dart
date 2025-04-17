import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieBox - Home'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to MovieBox!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
