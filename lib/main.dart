import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/splash/splash_screen.dart';
import 'theme.dart';

void main() {
  runApp(MarketKurly());
}

class MarketKurly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Market Kurly UI",
      // (1)
      initialRoute: SplashScreen.routeName,
     // (2)
      routes: route,
      // (3)
      theme: theme(),
    );
  }
}

