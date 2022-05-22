import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/category/category_screen.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/screens/mypage/my_page_screen.dart';
import 'package:plant_app/screens/recommend/recommend_screen.dart';
import 'package:plant_app/screens/search/search_screen.dart';
import 'package:plant_app/models/nav_item.dart';
import 'package:plant_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/Notice_board.dart';
import 'package:plant_app/screens/recipe/recipe.dart';
class MainScreens extends StatefulWidget {
  static String routeName = "/main_screens";

  const MainScreens({Key? key}) : super(key: key);

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          recipe(),
          CategoryScreen(),
          board(),
          MyPageScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
        currentIndex:_selectedIndex,
        backgroundColor: Colors.white,
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

  void onTaped(index) {
    setState((){
      _selectedIndex = index;
    });
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
            color: isActive ? kPrimaryColor : Colors.black),
      ),
    ),
      label: label,
    );
  }
}




