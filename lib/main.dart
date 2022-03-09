import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'main2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final firestore = FirebaseFirestore.instance;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int tab=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      Scaffold(
      appBar: AppBar(title:  Text('HCI'),actions: [
        IconButton(onPressed: (){

        },icon: Icon(Icons.send))
      ],),

      body: [Text('home'),Text('shop'),Main2()][tab],
        bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.30),
        currentIndex: tab,
          backgroundColor: Colors.grey,

          onTap: (i){
            setState(() {
              tab=i;
            });
          },
          items: [
            BottomNavigationBarItem(
              
                label: '홈',
                icon: Icon(Icons.home),

            )
          ,BottomNavigationBarItem(
                label: '샵',
                icon: Icon(Icons.shopping_bag),
            ),BottomNavigationBarItem(
        label: '책',
        icon: Icon(Icons.library_books),
      )]
        ) ,
    ));
  }
}

