import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/mypage/components/profile_my_plant.dart';
import 'package:plant_app/screens/mypage/components/profile_tab_bar.dart';

import 'components/profile_buttons.dart';
import 'components/profile_count_info.dart';
import 'components/profile_header.dart';
import 'components/profile_tab.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var plant_name = " ";
  var content = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("마이 페이지"),
        backgroundColor: mainColor,

      ),

      body: Column(

        children: [
          SizedBox(height: 14),
          ProfileHeader(),
          SizedBox(height: 18),
          //ProfileCountInfo(),
          // SizedBox(height: 10),
          // ProfileButtons(),
          //SizedBox(height: 10,),
          SizedBox(height: 12,),

          ElevatedButton(

              onPressed:() async{
                DocumentSnapshot test = await firestore.collection('식물등록').doc('user1').get();
              setState(() {
                plant_name = test['plant_name'];
                content = test['content'];
              });
                } ,
              style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
              child: Text("내가 키우고 있는 식물 보기",
            style:TextStyle(

                color: Colors.black38,
                fontSize: 14,
                fontWeight: FontWeight.normal
            ),))
          ,
          SizedBox(height: 20,),
          SizedBox(height: 15,),
          Container(

            height: 120,
            width: 400,
            decoration: BoxDecoration(
              color: beige,
              border: Border.all(
                color: Colors.white54,
                style: BorderStyle.solid,
                width: 2
              )
            ),

            child: Text("식물 이름 :  " + plant_name,),
          ),



          SizedBox(height: 12,),
          Container(
            height: 120,
            width: 400,
            decoration:BoxDecoration(
                color: Colors.red,
                border: Border.all(
                    color: Colors.white54,
                    style: BorderStyle.solid,
                    width: 2
                )
            ),
            child: Text("내용 :  " + content,),
          ),




          //Expanded(child:TabPage())
          //Expanded(child: ProfileTab()),

        ],
      ),
    );
  }

}
