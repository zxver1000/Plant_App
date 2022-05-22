import 'package:flutter/material.dart';
import 'package:plant_app/screens/login/loin_page.dart';
import 'package:plant_app/screens/main_screens.dart';
import 'routes.dart';
import 'screens/splash/splash_screen.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return MainScreens();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}

