import 'package:coffeeapp/screens/delivery.dart';
import 'package:coffeeapp/screens/detail.dart';
import 'package:coffeeapp/screens/home.dart';
import 'package:coffeeapp/screens/login.dart';
import 'package:coffeeapp/screens/forgot.dart';
import 'package:coffeeapp/screens/order.dart';
import 'package:coffeeapp/screens/register.dart';
import 'package:coffeeapp/screens/welcome.dart';
import 'package:coffeeapp/admin/adminHome.dart';
import "package:coffeeapp/admin/user.dart";
import 'package:coffeeapp/admin/product.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        return buildRoute(
          const Welcome(),
          settings: settings,
        );
      case Routes.login:
        return buildRoute(
          Login(),
          settings: settings,
        );
      case Routes.forgot:
        return buildRoute(
          Forgot(),
          settings: settings,
        );
      case Routes.register:
        return buildRoute(
          Register(),
          settings: settings,
        );
      case Routes.adminHome:
        return buildRoute(
          AdminHome(),
          settings: settings,
        );
      case Routes.user:
        return buildRoute(
          User(),
          settings: settings,
        );
      case Routes.product:
        return buildRoute(
          Product(),
          settings: settings,
        );
      case Routes.home:
        return buildRoute(
          const Home(),
          settings: settings,
        );
      case Routes.detail:
        final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return buildRoute(
          Detail(
            name: args['name'],
            image: args['image'],
            price: args['price'],
            stars: args['stars'],
            description: args['description'],
          ),
          settings: settings,
        );
      case Routes.order:
        return buildRoute(
          const Order(),
          settings: settings,
        );
      case Routes.delivery:
        return buildRoute(
          const Delivery(),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Seems the route you\'ve navigated to doesn\'t exist!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
