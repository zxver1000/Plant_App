import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/mypage/components/profile_image.dart';
import 'package:plant_app/screens/mypage/components/profile_my_plant.dart';

import 'components/profile_buttons.dart';
import 'components/profile_count_info.dart';
import 'components/profile_header.dart';
import 'components/profile_tab.dart';
import 'package:provider/provider.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key,this.data}) : super(key: key);
 final data;
  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class plant_data{

  var plant_name = " ";
  var content = " ";
  var water_cycle = " ";

 plant_data(this.plant_name,this.content,this.water_cycle);
}


class _MyPageScreenState extends State<MyPageScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var plant_name = " ";
  var content = " ";
  var water_cycle = " ";

 var datas=[];
  @override
  void initState() {
    // TODO: implement initState
     print("zzzzzzzzzzzzzzzzzzz");
    super.initState();

  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("마이 페이지"),
        backgroundColor: mainColor,

      ),


      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(

              children : [
                SizedBox(height: 14),
                //RegistProfile(),
                ProfileHeader(),
                SizedBox(height: 18),
                //ProfileCountInfo(),
                // SizedBox(height: 10),
                // ProfileButtons(),
                //SizedBox(height: 10,),
                SizedBox(height: 12,),


                SizedBox(height: 20,),
                SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 200,

                  decoration: BoxDecoration(
                      color: beige,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: Colors.white54,
                          style: BorderStyle.solid,
                          width: 2
                      )
                  ),

                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("나의 식물\n키우는 식물 개수 :  " + widget.data.length.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
            Container(child:   Divider(height: 1,color: Colors.black,),)
                      ,
                 Padding(padding:EdgeInsets.all(13),
                 child: Text(""),),
                 Container(
                   height: 100,
                   child: ListView.builder(

                   scrollDirection: Axis.horizontal,
                 itemCount: widget.data.length,
                     itemBuilder: (BuildContext context,int index){
                     return Column(children: [
                       IconButton(onPressed: (){}, icon: Icon(Icons.water_drop)),
                       Text(widget.data[index].plant_name.toString())
                     ,Padding(padding:EdgeInsets.only(left: 100)
                       )],
                     );
                     },

                 )
                   ,)



                    ],



                  )
                ),








                //Expanded(child:TabPage())
                //Expanded(child: ProfileTab()),

              ],
            ),
          ),
          SliverToBoxAdapter(
            child:  Divider(height: 1,color: Colors.black,),
          )
,
          SliverToBoxAdapter(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start
            ,children: [
    Padding(padding:EdgeInsets.only(top: 20))
    ,
    Padding(padding: EdgeInsets.only(left:15),
    child:  Text("게시판에 올린 글들",style: TextStyle(fontWeight: FontWeight.bold),),)
              ,

            ],),
          ),



        ],
      ),
    );
  }

}



