import 'package:flutter/material.dart';
import 'package:vac_card/app/pages/home/view.dart';
import 'package:vac_card/app/pages/login/view.dart';
import 'package:vac_card/app/pages/scan/view.dart';
import 'package:vac_card/app/pages/splash/view.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class RouteManager {
  static const String initial = AppRoutes.splash;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(builder: (_) => const HomePage());
      case AppRoutes.scan:
        return MaterialPageRoute<dynamic>(builder: (_) => const ScanPage());
      case AppRoutes.login:
        return MaterialPageRoute<dynamic>(builder: (_) => const LoginPage());
      case AppRoutes.splash:
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashPage());

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
} 

/* Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    AppRoutes.home: (BuildContext context) => const HomePage(),
    AppRoutes.detail: (BuildContext context) => const DetailPage(scanText: '',),
  };
} */
