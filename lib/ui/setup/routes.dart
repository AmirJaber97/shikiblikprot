import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shik_i_blisk/app/logger.dart';
import 'package:shik_i_blisk/constants/app_routes.dart';
import 'package:shik_i_blisk/ui/home/home.dart';
import 'package:shik_i_blisk/ui/home/pages/main_page.dart';
import 'package:shik_i_blisk/ui/home/pages/page_1.dart';
import 'package:shik_i_blisk/ui/home/pages/page_2.dart';
import 'package:shik_i_blisk/ui/home/pages/page_3.dart';

class Routes {
  static final logger = getLogger('Router');

  static Route<dynamic> generateRoute(RouteSettings settings) {
    logger.i(
        'generateRoute | name: ${settings.name} arguments: ${settings.arguments}');

    switch (settings.name) {
      case RoutePaths.Home:
        return CupertinoPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }

  static Route<dynamic> innerRoute(RouteSettings settings) {
    logger.i(
        'generateRoute | name: ${settings.name} arguments: ${settings.arguments}');

    switch (settings.name) {
      case RoutePaths.MainPage:
        return CupertinoPageRoute(builder: (_) => MainPage());
      case RoutePaths.Page1:
        return CupertinoPageRoute(builder: (_) => Page1());
      case RoutePaths.Page2:
        return CupertinoPageRoute(builder: (_) => Page2());
      case RoutePaths.Page3:
        return CupertinoPageRoute(builder: (_) => Page3());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
