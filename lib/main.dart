import 'package:flutter/material.dart';
import 'package:plant_app/screens/login/loin_page.dart';
import 'package:plant_app/screens/main_screens.dart';
import 'routes.dart';
//import 'screens/splash/splash_screen.dart';
import 'theme.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/screens/recipe/recipe_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

class Data{
  var name;
  var title;
  var content;
  var num;
  var visit=0;
  var comment=1;
  var time;
  var commentSubject=[];
  File userImage;
  Data(this.name,this.title,this.content,this.num,this.userImage);

}
class Data2{
  var name;
  var title;
  var content;
  var num;
  var visit=0;
  var comment=1;
  var time;
  var commentSubject=[];
  Data2(this.name,this.title,this.content,this.num);

}
class recipeData extends ChangeNotifier{
  var saladData=saladRecipe;

  plusVisit(recipe recipe)
  {
    recipe.visit++;
    notifyListeners();
  }

}




class plants{

  var plant_name = " ";
  var content = " ";
  var water_cycle = " ";
  var water_checking= 0;
  var data=[];
  plants(this.plant_name,this.content,this.water_cycle);
}

class plant extends ChangeNotifier{

  var plant_datas=[];

  void deleteData(var data)
  {
    for(var i=0;i<plant_datas.length;i++) {
      if(plant_datas[i].plant_name==data.plant_name) {
        plant_datas.removeAt(i);
      }
    }
    notifyListeners();
  }


  void addPlant(var data){

    plant_datas=[...plant_datas,data];
    notifyListeners();
   }
   void changechecking(var index) {
     if (plant_datas[index].water_checking == 1) {
       plant_datas[index].water_checking = 0;
     }
     else
       {
         plant_datas[index].water_checking = 1;
       }
     notifyListeners();
   }

}

class boardData extends ChangeNotifier{
// var userData=[Data("농부농부1", "토마토키우기 꿀팁알려드립니다", "꿀팁꿀팁", 1, File())];
var userData=[];
List<Data2> freeData=[Data2("감자감자", "토마토키우기꿀팁 알려드립니다", "01.토마토키운다", 1,),
  Data2("감자키우기", "2022 05 30 감자 성장일기", "01.토마토키운다", 1,)

];
plusVisit(Data data)
{
    data.visit=data.visit+1;
    notifyListeners();
}
addcomment(Data data,String comment)
{
    data.commentSubject=[...data.commentSubject,comment];
    data.comment=data.comment+1;
    notifyListeners();
}

addData(var name,var title,var content,var num1,var image)
{
  var newOne=Data(name,title,content,num1,image);
  newOne.comment=1;
  newOne.visit=0;
  newOne.commentSubject=["gdgd"];
  var now=DateTime.now();
  String formatDate = DateFormat('yy/MM/dd - HH:mm:ss').format(now);
  newOne.time=formatDate;

  userData=[newOne,...userData];
  notifyListeners();
}

  var item =1;
  change(){
    item++;
    notifyListeners();
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);

  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (c) => boardData()),
        ChangeNotifierProvider(create: (c) => recipeData()),
        ChangeNotifierProvider(create: (c) => plant()),
      ],
        child: PlantApp(),)
  );
}
class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "plant app UI",
      // (1)
      // initialRoute: SplashScreen.routeName,
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

