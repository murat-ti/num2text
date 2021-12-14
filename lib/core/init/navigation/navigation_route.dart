import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:num2text/view/calculator/view/calculator_view.dart';
import 'package:num2text/view/home/view/home_view.dart';
import '../../widgets/card/not_found_navigation_widget.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.homeView:
        return normalNavigate(const HomeView(), RouteSettings(name: NavigationConstants.homeView, arguments: args.arguments));
      case NavigationConstants.calculatorView:
        return normalNavigate(const CalculatorView(), const RouteSettings(name: NavigationConstants.calculatorView));
      default:
        return normalNavigate(const NotFoundNavigationWidget(), const RouteSettings(name: 'Not found'));
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
