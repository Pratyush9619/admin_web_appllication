import 'package:flutter/material.dart';
import 'package:web_appllication/Authentication/login_register.dart';
import 'package:web_appllication/MenuPage/project_planning.dart';
import 'package:web_appllication/MenuPage/user.dart';
import 'package:web_appllication/OverviewPages/ev_dashboard/ev_dashboard.dart';
import 'package:web_appllication/OverviewPages/o&m_dashboard/o&m_dashboard_screen.dart';
import 'package:web_appllication/OverviewPages/sidebar_nav/nav_screen.dart';
import 'package:web_appllication/Planning/cities.dart';
import 'package:web_appllication/components/page_routeBuilder.dart';
import 'package:web_appllication/screen/demand%20energy%20management/demandScreen.dart';
import 'package:web_appllication/screen/split_dashboard/split_dashboard.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case 'project-panning':
        return MaterialPageRoute(
          builder: (_) => const ProjectPanning(),
        );

      case 'user-page':
        return MaterialPageRoute(
          builder: (_) => const MenuUserPage(),
        );

      case '/dashboard':
        return MaterialPageRoute(
          builder: (_) => const SplitDashboard(),
        );

      case '/evDashboard':
        bool args = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) => EVDashboardScreen(showAppBar: args),
        );

      case '/o&mDashboard':
        bool args = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) => ONMDashboard(showAppBar: args),
        );

      case '/demand':
        return MaterialPageRoute(
          builder: (_) => DemandEnergyScreen(),
        );

      case '/cities':
        return CustomPageRoute(
          page: const CitiesPage(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginRegister(),
        );

      case '/nav':
        final userId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => NavigationPage(userId: userId),
        );

      // Add more cases for additional routes
      default:
        // If the requested route is not found, you can navigate to an error screen
        return MaterialPageRoute(
          builder: (_) => const ONMDashboard(),
        );
    }
  }
}
