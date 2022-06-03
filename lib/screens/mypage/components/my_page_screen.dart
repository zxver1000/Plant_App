import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/mypage/components/profile_image.dart';
import 'package:plant_app/screens/mypage/components/profile_my_plant.dart';
import 'package:plant_app/notification.dart';
import 'profile_buttons.dart';
import 'profile_count_info.dart';
import 'profile_header.dart';
import 'profile_tab.dart';
import 'package:provider/provider.dart';
import 'package:plant_app/main.dart';
import 'package:plant_app/Notice_board.dart';

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



                Container(
                  margin: EdgeInsets.all(10),
                  height: 250,

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
                   height: 120,
                   child: ListView.builder(

                   scrollDirection: Axis.horizontal,
                 itemCount: widget.data.length,

                     itemBuilder: (BuildContext context,int index){
                     return Padding(padding: EdgeInsets.only(left:50),child:
                     Column(children: [
                       IconButton(onPressed: (){
                         print("!11");
                         //showNotification();
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context) {
                               return plantInformation(data: widget.data[index],);
                             })
                         );
                       }, icon: Icon(Icons.water_drop)),
                       Text(widget.data[index].plant_name.toString()),

                      context.watch<plant>().plant_datas[index].water_checking==1?Text("D-day : "+widget.data[index].water_cycle)
                           :ElevatedButton(onPressed: (){
                            context.read<plant>().changechecking(index);
                       }, child: Text("V")

                       )
                       ,


                     ],
                     ),);

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
    child:  Text("내가 올린 글들",style: TextStyle(fontWeight: FontWeight.bold),),)
              ,

            ],),
          ),
          SliverFixedExtentList(
            itemExtent: 80.0,
            delegate: SliverChildBuilderDelegate((BuildContext context,int index){
              return Padding(
                padding:EdgeInsets.only(top: 1),
                child:
                Column(children: <Widget>[ ListTile(
                  // leading: dataset[index].userImage!=null?Image.file(dataset[index].userImage):Text(""),
                  leading:Icon(Icons.list_alt_outlined,size: 50,color:Colors.black,),
                    title:Text(context.watch<boardData>().userData[index].title.toString()),
                    subtitle: Text(context.watch<boardData>().userData[index].name.toString()+"    "+"조회 "+context.watch<boardData>().userData[index].visit.toString()+"   "+"댓글 "+context.watch<boardData>().userData[index].comment.toString() ),
                    onTap : ()=>{

              context.read<boardData>().plusVisit(context.read<boardData>().userData[index]),

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return information(indexs:index,board_name: "자유게시판",);
                          }))
                      ,


              },

                    trailing:context.watch<boardData>().userData[index].userImage!=null?Image.file(context.watch<boardData>().userData[index].userImage):Text("")
                ),
                  Divider(height: 1,color: Colors.black,)],),

              );
            },childCount: context.watch<boardData>().userData.length),
          )



        ],
      ),
    );
  }

}




class plantInformation extends StatefulWidget {
  const plantInformation({Key? key,this.data}) : super(key: key);
final data;
  @override
  State<plantInformation> createState() => _plantInformationState();
}

class _plantInformationState extends State<plantInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("마이식물페이지"),
          backgroundColor: mainColor),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [   SizedBox(height: 14),
            Container(
              margin: EdgeInsets.all(10),
              height: 260,
              width: 600,
              decoration: BoxDecoration(
                  color: beige,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: Colors.white54,
                      style: BorderStyle.solid,
                      width: 2
                  )
              ),child: Row(

            children: [
                Icon(Icons.water_damage,size: 120,)
            ,
Column(
  mainAxisAlignment: MainAxisAlignment.start,

children: [
  Padding(padding: EdgeInsets.all(30),child: Column(children: [
    Text("이름 : "+widget.data.plant_name,style: TextStyle(fontSize: 15),),
    SizedBox(height: 20,),
    Text("내용 : "+widget.data.content,style: TextStyle(fontSize: 15)),
    SizedBox(height: 20,),
    Text("물주기 : "+widget.data.water_cycle+"일",style: TextStyle(fontSize: 15)),
    SizedBox(height: 20,),
    Text("키우기시작한 날짜 : "+widget.data.water_cycle+"일",style: TextStyle(fontSize: 15)),
    SizedBox(height: 20,),
    Text("수확 가능 시기 : "+widget.data.water_cycle+"일뒤",style: TextStyle(fontSize: 15)),
    
  ],),)
],)


            ],),
            )

              ],),
          )
        ],
      )
      ,


      bottomNavigationBar: BottomAppBar(

    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween
      ,children: [TextButton(onPressed: (){
      Navigator.pop(context,false);
    }, child: Row(children: [Icon(Icons.list),Text("처음으로"),],),
      style:TextButton.styleFrom(primary: Colors.black),),

       ],),
    ),
    );
  }
}
