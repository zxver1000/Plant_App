import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/main.dart';
import 'package:provider/provider.dart';

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

class board extends StatefulWidget  {
  const board({Key? key}) : super(key: key);

  @override
  _boardState createState() => _boardState();
}

class _boardState extends State<board> with SingleTickerProviderStateMixin {

var dataset=[];
plusVisit(Data data)
{
  setState(() {
    data.visit=data.visit+1;
  });
}

addcomment(Data data,String comment)
{
  setState(() {
    data.commentSubject=[...data.commentSubject,comment];
 data.comment=data.comment+1;
  });
}

addData(var name,var title,var content,var num1,var image)
{
  var new_one=Data(name,title,content,num1,image);
  new_one.comment=1;
  new_one.visit=0;
  new_one.commentSubject=["gdgd"];
  var now=DateTime.now();
  String formatDate = DateFormat('yy/MM/dd - HH:mm:ss').format(now);
  new_one.time=formatDate;
  setState(() {
    dataset=[new_one,...dataset];
  });
}


late TabController? tab;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  tab=TabController(
    length: 2,
    vsync: this,
  );
}
List<Data2> freeData=[Data2("감자감자", "토마토키우기꿀팁 알려드립니다", "01.토마토키운다", 1,),
  Data2("감자키우기", "2022 05 30 감자 성장일기", "01.토마토키운다", 1,)
];
var indexs=0;
  @override
  Widget build(BuildContext context) {
  var board_name=["자유게시판","자랑게시판","레시피"];
  final myController=TextEditingController();
    return Scaffold(
      appBar:AppBar(
        title: Text("게시판"),
        backgroundColor: mainColor,
    automaticallyImplyLeading: false,
    actions: [],
    ),
   floatingActionButton: FloatingActionButton(
     child: Text('+'),
     onPressed:(){
       Navigator.push(context,
           MaterialPageRoute(builder: (context) {
             return writing(addData:addData);
           })
       );
     },
   ),

      body: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title:TabBar(controller: tab,onTap:(i){
            indexs=i;
          },
          tabs: [Tab(text:board_name[0],),Tab(text:board_name[1],)],),
        ),
        body: TabBarView(

          controller: tab,
          children: <Widget>[
        CustomScrollView(
        slivers:<Widget>[
          SliverFixedExtentList(
          itemExtent: 80.0,
          delegate: SliverChildBuilderDelegate((BuildContext context,int index){
            return Padding(
                padding:EdgeInsets.only(top: 1),
                child:
                Column(children: <Widget>[ ListTile(
                  // leading: dataset[index].userImage!=null?Image.file(dataset[index].userImage):Text(""),
                  title:Text(context.watch<boardData>().userData[index].title.toString()),
                  subtitle: Text(context.watch<boardData>().userData[index].name.toString()+"    "+"조회 "+context.watch<boardData>().userData[index].visit.toString()+"   "+"댓글 "+context.watch<boardData>().userData[index].comment.toString() ),
                  onTap : ()=>{
                    print("tab :g"+indexs.toString()),
                    context.read<boardData>().plusVisit(context.read<boardData>().userData[index]),



                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return information(indexs:index,board_name: board_name[indexs-1],);
                        }))
                  },
                    trailing:context.watch<boardData>().userData[index].userImage!=null?Image.file(context.watch<boardData>().userData[index].userImage):Text("")
                ),
                  Divider(height: 1,color: Colors.black,)],),

            );
          },childCount: context.watch<boardData>().userData.length),
        )
          ]
      ),

           //두번쨰꺼위치!!!
            CustomScrollView(
                slivers:<Widget>[
                  SliverFixedExtentList(
                    itemExtent: 80.0,
                    delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                      return Padding(
                          padding:EdgeInsets.only(top: 1),
                          child:
                          Column(children: <Widget>[ ListTile(
                            // leading: dataset[index].userImage!=null?Image.file(dataset[index].userImage):Text(""),
                            title:Text(context.watch<boardData>().freeData[index].title.toString()),

                            subtitle: Text(context.watch<boardData>().freeData[index].name.toString()+"    "+"조회 "+context.watch<boardData>().freeData[index].visit.toString()+"   "+"댓글 "+context.watch<boardData>().freeData[index].comment.toString() ),
                            onTap : ()=>{

                            },

                          ),
                            Divider(height: 1,color: Colors.black,)],)
                      );
                    },childCount: freeData.length),
                  )
                ]
            )




          ],
        )

      )


    );

  }
}



class writing extends StatefulWidget {
  const writing({Key? key,this.addData}) : super(key: key);
  final addData;

  @override
  _State createState() => _State();
}

class _State extends State<writing> {
  final controllerName=TextEditingController();
  final controllerTitle=TextEditingController();
  final controllerContent=TextEditingController();
  var userimage;
var id=1;
var str="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextButton(child: Text("게시글 올리기"),onPressed: (){
        Navigator.pop(context,false);
      },
      ),actions: [


        IconButton(onPressed: (){
          print("여기야?");
          //name,title,content,따봉 위에서이미지로바꾸기
          if(userimage!=null) {
            print("hihi");
            context.read<boardData>().addData(
                "작성자", controllerTitle.text, controllerContent.text,1,userimage);


    print(context.read<boardData>().userData[0].title);

            /*
            widget.addData(
                "작성자", controllerTitle.text, controllerContent.text,1,userimage);
            print("add");
          */
          }

          Navigator.pop(context,false);
        },icon: Icon(Icons.add))
      ],),
      body:CustomScrollView(

          slivers:<Widget>[


            SliverToBoxAdapter(
                child:Column(
        mainAxisAlignment: MainAxisAlignment.start,children: [
        Text("")
        ,





        TextField(controller: controllerTitle,decoration: InputDecoration(hintText: "제목"),style: TextStyle(fontSize: 20),)
        ,TextField(controller: controllerContent,style: TextStyle(fontSize: 15),maxLines: 10,
        decoration: InputDecoration(border: InputBorder.none,hintText: "내용을 입력하세요!"),)
     ,
 userimage!=null?Image.file(userimage,width: 400,height: 400,):Text("")
        ],))])
      ,
      bottomNavigationBar:BottomAppBar(

       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
         IconButton(onPressed: () async{
           var picker = ImagePicker();
           //camera -> ImageSource.camera
           var image = await picker.pickImage(source: ImageSource.gallery);
           //예외처리
           if(image!=null) {
             setState(() {
               userimage = File(image.path);
             });
           }
             Image.file(userimage);
           print("-------------------");
           print(userimage);
           print("000000000");

         }, icon: Icon(Icons.picture_in_picture))
         ,
           IconButton(onPressed: () async{
             var picker = ImagePicker();
             //camera -> ImageSource.camera
             var image = await picker.pickImage(source: ImageSource.camera);


           }, icon: Icon(Icons.camera_alt_rounded))
         ],
       ),
      ) ,
    );
  }
}

class information extends StatefulWidget {
  const information({Key? key,this.data,this.board_name,this.addcomment,this.indexs}) : super(key: key);
  final data;
  final board_name;
  final indexs;
  final addcomment;
  @override
  State<information> createState() => _informationState();
}

class _informationState extends State<information> {


  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    print("widget index : "+widget.indexs.toString());



    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: TextButton(child: Text("게시판"),onPressed: (){

    })
        ),
      body:CustomScrollView(
        slivers: [
       SliverToBoxAdapter(
         child: Padding(
           padding:EdgeInsets.all(13),
             child:Text(widget.board_name.toString()+" >")),
       )
          ,SliverToBoxAdapter(
            child: Padding(padding: EdgeInsets.all(13),
              child:Text(context.watch<boardData>().userData[widget.indexs].title.toString(),style:TextStyle(fontSize: 30) ,) ,),
          )
          ,
          SliverToBoxAdapter(
            child: ListTile(
              leading: Icon(Icons.person,size:50),
              title:Text(context.watch<boardData>().userData[widget.indexs].name.toString()),
              subtitle: Text(context.watch<boardData>().userData[widget.indexs].time.toString()+" "+"조회 "+context.watch<boardData>().userData[widget.indexs].visit.toString()),
            ),
          ),
          SliverToBoxAdapter(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Divider(height: 1,color: Colors.black,),
                Padding(padding:EdgeInsets.only(top: 10),),

                Text(""),
                Padding(padding: EdgeInsets.all(10),child:Text(context.watch<boardData>().userData[widget.indexs].content.toString()) ,) ,
                Padding(padding:EdgeInsets.only(top: 20),),
                context.watch<boardData>().userData[widget.indexs].userImage!=null?Image.file(context.watch<boardData>().userData[widget.indexs].userImage,width: 400,height: 400,):Text("")
              ],
            ) ,)
,
        ],
      ) ,bottomNavigationBar: BottomAppBar(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween
      ,children: [TextButton(onPressed: (){
        Navigator.pop(context,false);
      }, child: Row(children: [Icon(Icons.list),Text("목록으로"),],),
        style:TextButton.styleFrom(primary: Colors.black),),
        TextButton(onPressed: (){
          Navigator.of(context,rootNavigator: true).push(
       CupertinoPageRoute<void>(builder: (BuildContext context)=>comments(index:widget.indexs))
          );

        },
            child:Row(children: [Icon(Icons.comment),Padding(padding: EdgeInsets.only(left: 5)),Text(context.watch<boardData>().userData[widget.indexs].comment.toString(),style: TextStyle(fontSize: 20),)],),
          style:TextButton.styleFrom(primary: Colors.black) , )],),
    ),
    );
  }
}

class comments extends StatefulWidget {
  const comments({Key? key,this.data,this.addcomment,this.index}) : super(key: key);
  final data;
  final index;
  final addcomment;
  @override
  State<comments> createState() => _commentsState();
}

class _commentsState extends State<comments> {
@override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }



  final controllerComment=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("작성하기"),),
      body: Column(
        children:<Widget>[
          Flexible(
            child:Stack(children: [Positioned(top:0.0,child: Text("")),
            buildItem(index:widget.index)],),

          ),Divider(height: 1.0,color: Colors.black,),
          Container(decoration:BoxDecoration(color: Theme.of(context).cardColor),
          child: Row(children: [Flexible(child:TextField(controller: controllerComment,decoration: InputDecoration(hintText: "댓글을 남겨보세요!") )
          ),TextButton(onPressed: (){
            print(controllerComment.text);

            context.read<boardData>().addcomment(context.read<boardData>().userData[widget.index],controllerComment.text.toString());


          }, child: Text("등록",),style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            primary: Colors.white
          ),)
          ],),)
        ],
      )
     
    );
  }
}

class buildItem extends StatefulWidget {
  const buildItem({Key? key,this.data,this.index}) : super(key: key);
 final data;
 final index;
  @override
  State<buildItem> createState() => _buildItemState();
}

class _buildItemState extends State<buildItem> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState

    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<boardData>().userData[widget.index].comment,
      itemBuilder: (BuildContext context,int index)=>
         Column(children: [ListTile(
           leading: Icon(Icons.person,size: 30,),
           title:Text(context.watch<boardData>().userData[widget.index].name.toString()),
           subtitle: Text(context.watch<boardData>().userData[widget.index].commentSubject[index].toString()),
         ),Divider(height: 1,color: Colors.black,)],) ,
    );
  }
}
