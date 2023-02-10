import 'package:car_note/src/features/car_info/presentation/pages/car_info.dart';
import 'package:car_note/src/features/car_info/presentation/pages/consumables_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = '/';
  static const String maintenanceRoute = '/maintenance_screen';
  static const String noRouteFound = 'No Route Found';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) => const ConsumablesScreen()));
      case Routes.maintenanceRoute:
        return MaterialPageRoute(builder: ((context) => const CarInfo()));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() => MaterialPageRoute(
      builder: (context) => const Scaffold(body: Center(child: Text(Routes.noRouteFound))));
}
