import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/mypage/components/profile_tab_bar.dart';

import 'components/profile_buttons.dart';
import 'components/profile_count_info.dart';
import 'components/profile_header.dart';
import 'components/profile_tab.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("마이 페이지"),
        backgroundColor: mainColor,

      ),

      body: Column(
        children: [
          SizedBox(height: 10),
          ProfileHeader(),
          SizedBox(height: 10),
          ProfileCountInfo(),
         // SizedBox(height: 10),
         // ProfileButtons(),
          SizedBox(height: 10,),
          Expanded(child:TabPage())

          //Expanded(child: ProfileTab()),
        ],
      ),
    );
  }
}
