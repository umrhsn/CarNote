import 'package:car_note/src/features/car_info/presentation/pages/car_info_screen.dart';
import 'package:car_note/src/features/consumables/presentation/pages/add_consumable.dart';
import 'package:car_note/src/features/consumables/presentation/pages/consumables_screen.dart';
import 'package:car_note/src/features/info/presentation/pages/dashboard_screen.dart';
import 'package:car_note/src/features/intro/presentation/pages/language_selection_screen.dart';
import 'package:car_note/src/features/intro/presentation/pages/onboarding_screen.dart';
import 'package:car_note/src/features/intro/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = '/';
  static const String chooseLanguageRoute = '/choose_language';
  static const String onboardingRoute = '/onboarding';
  static const String carInfoRoute = '/car_info';
  static const String consumablesRoute = '/consumables_screen';
  static const String addConsumableRoute = '/add_consumable';
  static const String infoRoute = '/info';
  static const String noRouteFound = 'No Route Found';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      case Routes.chooseLanguageRoute:
        return MaterialPageRoute(builder: ((context) => const LanguageSelectionScreen()));
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: ((context) => const OnboardingScreen()));
      case Routes.carInfoRoute:
        return MaterialPageRoute(builder: ((context) => const CarInfoScreen()));
      case Routes.consumablesRoute:
        return MaterialPageRoute(builder: ((context) => const ConsumablesScreen()));
      case Routes.addConsumableRoute:
        return MaterialPageRoute(builder: ((context) => const AddConsumableScreen()));
      case Routes.infoRoute:
        return MaterialPageRoute(builder: ((context) => const DashboardScreen()));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() => MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text(Routes.noRouteFound))));
}
