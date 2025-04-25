import 'package:flutter/material.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../features/details/presentation/movie_details_screen.dart';
import '../features/home/presentation/home_screen.dart';
import 'app_route.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoute.details:
        final String movieId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => MovieDetailsScreen(id: movieId));
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
