import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
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
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/screens/mypage/privateCalandar.dart';
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
  var water_checking = 0;
  var water_checks = List.filled(10, 0);


  DateTime nowTime = DateTime.parse(DateTime.now().toString().substring(0,10) + " 00:00:00.000Z");
  CollectionReference event = FirebaseFirestore.instance.collection('events');
  void addcl() async{
    await event.add({
      'Date': nowTime.toString().substring(0,10),
      'Title': "hihi3",
    }).then((value)
    {
      print("11");
      print(value);

    });
  }


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
                      Text("나의 식물\n키우는 식물 개수 :  " + context.read<plant>().plant_datas.length.toString(),
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
                 itemCount: context.watch<plant>().plant_datas.length,

                     itemBuilder: (BuildContext context,int index){
                     return Padding(padding: EdgeInsets.only(left:50),child:
                     Column(children: [
                       IconButton(onPressed: (){
                         print("!11");
                         //showNotification();
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context) {
                               return plantInformation(data: context.read<plant>().plant_datas[index],);
                             })
                         );
                       },
                           icon: Image.asset('assets/icons/plant.png'),
                       ),
                       Text(context.watch<plant>().plant_datas[index].plant_name.toString()),

                      context.watch<plant>().plant_datas[index].water_checking==1?Text("D-day : "+widget.data[index].water_cycle)
                           :ElevatedButton(onPressed: (){
                             water_checks[index] = 1;
                            context.read<plant>().changechecking(index);
                       },
                          child: Text("V")
                        ,
                        style: ElevatedButton.styleFrom(
                            primary: CupertinoColors.activeGreen
                        ),

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

  var strToday = '';

  String getToday(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    strToday = formatter.format(now);
    return strToday;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  DateTime nowTime = DateTime.parse(DateTime.now().toString().substring(0,10) + " 00:00:00.000Z");
void deleteData(var col) async{
  var data = await db.collection("식물등록").where("plant_name",isEqualTo: col).get();
  print(data);
//print(data.toString());
  var details = data.docs.toList();

  details.forEach((d) async{
    print(d.id);
    var s=await db.collection("식물등록").doc(d.id).delete();

  var k=plants(d['plant_name'],d['content'],d['water_cycle']);
    context.read<plant>().deleteData(k);
  });
  Navigator.pop(context,false);
}

  @override
  Widget build(BuildContext context) {

    strToday = getToday();
    DateTime dateTime = DateTime.now();
    //DateTime dateTime2 = dateTime.add(Duration(days:widget.data.water_cycle));
    DateTime dateTime2 = dateTime.add(const Duration(days:3));
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strNextWatering = formatter.format(dateTime2);
    var water_cycle = int.parse(widget.data.water_cycle);
    var added = dateTime.add(new Duration(days: water_cycle));
    String strAddedWatering = formatter.format(added);


    return Scaffold(
      appBar: AppBar(title: Text("마이식물페이지"),
          backgroundColor: mainColor),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 14),
            Container(
              margin: EdgeInsets.all(10),
              height: 260,
              width: 600,
              decoration: BoxDecoration(
                  color: color_g,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: Colors.white54,
                      style: BorderStyle.solid,
                      width: 2
                  )
              ),
              child: Row(

            children: [
              Image(image: AssetImage("assets/icons/plant1.png"),height: 150,),
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
                    Text("시작 날짜 : "+strToday+"일",style: TextStyle(fontSize: 15)),
                    SizedBox(height: 20,),
                    Text("수확 가능 시기 : "+widget.data.water_cycle+"0일뒤",style: TextStyle(fontSize: 15)),

                  ],),)
                ],)


            ],
              ),
            ),

             Column(
               children: [
                 SizedBox(
                   width: double.infinity,
                   child: Container(
                     child: Padding(
                       padding: EdgeInsets.all(12),
                       child: Text('물 상태' ,

                       ),
                     ),
                   ),
                 ),

                 Row(
                   children: [
                     widget.data.water_checking==1? Column(children: [Image(image: AssetImage("assets/icons/water-full.png"), width: 50,height: 50,),Text('100%',style: TextStyle(backgroundColor: Colors.redAccent),)],)
                     : Column(children: [Image(image: AssetImage("assets/icons/water-empty.png"),width: 50,height: 50,),Text('0%')],)


                   ],
                 ),
                 Divider(thickness: 1,color: Colors.grey,),
                 SizedBox(
                   width: double.infinity,
                   child: Container(
                     child: Padding(
                       padding: EdgeInsets.all(12),
                       child: Text('물 줄 시간'),
                     ),
                   ),
                 ),
                 Column(

                   children: [

                     Text('⦁' + strToday + " (오늘)"),
                     Text('⦁' + strAddedWatering + "(다음 물주기)"),


                   ],
                 ),
                 Divider(thickness: 1,color: Colors.grey,),
                 Column(
                   children: [
                     Text('⦁영양 상태 : 이상 없음'),
                     ElevatedButton(onPressed: (){

                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) {
                             return privateCalander(data: widget.data);
                           })
                       );


                     }, child: Text("캘린더보기"))

                   ],
                 )

               ],
             )

              ],
            ),




          ),
        ],
      ),

     /*    Column(
            children:[
              SizedBox(
                width: double.infinity,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("물 상태"),
                  ),

              ),

              ),
              Row(

                children: [
                  Image(image: AssetImage("assets/icons/water-empty.png"),width: 50,height: 50,)
                  ,Image(image: AssetImage("assets/icons/water-half.png"), width: 50,height: 50,),
                  Image(image: AssetImage("assets/icons/water-full.png"), width: 50,height: 50,),

                ],
              ),


            ],


          ),




          ),
    ),
        ],
      ),
*/


      bottomNavigationBar: BottomAppBar(

    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween
      ,children: [TextButton(onPressed: (){
      Navigator.pop(context,false);
    }, child: Row(children: [Icon(Icons.list),Text("처음으로"),],),
      style:TextButton.styleFrom(primary: Colors.black),),
      ElevatedButton(onPressed: (){
        deleteData(widget.data.plant_name);
      }, child: Text("키우기완료"))
       ],),
    ),
    );
  }
}


