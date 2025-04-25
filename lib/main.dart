import 'package:flutter/material.dart';
import 'app/app_route.dart';
import 'app/router_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoute.splash,
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}


