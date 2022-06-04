import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/main.dart';
import 'package:plant_app/screens/category/category_screen.dart';
import 'package:plant_app/screens/category_2/category.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/screens/mypage/components/my_page_screen.dart';
import 'package:plant_app/screens/recommend/recommend_screen.dart';
import 'package:plant_app/screens/search/search_screen.dart';
import 'package:plant_app/models/nav_item.dart';
import 'package:plant_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/Notice_board.dart';
import 'package:plant_app/screens/recipe/recipe.dart';
import 'package:plant_app/notification.dart';
import 'package:provider/provider.dart';



class MainScreens extends StatefulWidget {
  static String routeName = "/main_screens";

  const MainScreens({Key? key}) : super(key: key);

  @override
  State<MainScreens> createState() => _MainScreensState();
}



class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 0;
  var datas=[];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initNotification();
    print("notification 인잇");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          recipe(),
          Category(),
          board(),
          MyPageScreen(data:datas)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white70,
        currentIndex:_selectedIndex,
        backgroundColor: mainColor,
        onTap: onTaped,
        items: List.generate(
          navItems.length,
              (index) => _buildBottomNavigationBarItem(
            icon:navItems[index].icon,
            label:navItems[index].label ,
            isActive: navItems[index].id == _selectedIndex ? true: false,
          ),
        ),
      ),
    );
  }

  Future CategoryScreen_m() async {

    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;
    var data = await db.collection('Plants').get();
    var details = data.docs.toList();

    details.forEach((d){
      print(d.id);
    });
  }


  void datadd () async{
    var result = await firestore.collection('식물등록').get();
    for(var data in result.docs) {
      var s = plants(data['plant_name'], data['content'], data['water_cycle']);
      if((datas.singleWhere((it) => it.plant_name==s.plant_name,
      orElse: ()=>null))!=null){
      }else
        {
          setState(() {
            datas = [...datas, s];
          });

          context.read<plant>().addPlant(s);
        }

    }
  }


  void onTaped(index) {
    setState((){
      _selectedIndex = index;
      if(index==4)
        {
          datadd();

        }
        }
      );
  }


  _buildBottomNavigationBarItem(
      { String? icon,
        String? label,
        bool isActive = false,
        GestureTapCallback? press}) {
    return BottomNavigationBarItem(icon: SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        onPressed: press,
        icon: SvgPicture.asset(icon!,
            color: isActive ? Colors.white : Colors.black),
      ),
    ),
      label: label,
    );
  }
}

