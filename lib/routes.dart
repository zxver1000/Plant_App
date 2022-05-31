import 'package:flutter/material.dart';
import 'package:plant_app/screens/category_2/make_plant.dart';

import 'screens/main_screens.dart';
import 'screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> route = {
  //
  SplashScreen.routeName: (context) => SplashScreen(),
  MainScreens.routeName: (context) => MainScreens(),
  MakePlant.routeName: (context) => MakePlant(),
};

