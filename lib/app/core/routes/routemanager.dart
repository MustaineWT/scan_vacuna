import 'package:flutter/material.dart';
import 'package:vac_card/app/pages/detail/view/detail_page.dart';
import 'package:vac_card/injection_container.dart';

import '../../pages/home/view/view.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class RouteManager {
  static const String initial = AppRoutes.splash;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(builder: (_) => const HomePage());
      /* case AppRoutes.detail:
        return MaterialPageRoute<dynamic>(builder: (_) => DetailPage()); */
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
