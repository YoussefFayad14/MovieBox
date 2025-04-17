import 'package:flutter/material.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../features/home/presentation/home._screen.dart';
import 'app_route.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
