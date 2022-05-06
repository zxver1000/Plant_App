
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Data{
  var name;
  var title;
  var content;

  var num;
  File userImage;
  Data(this.name,this.title,this.content,this.num,this.userImage);
}



class board extends StatefulWidget {
  const board({Key? key}) : super(key: key);

  @override
  _boardState createState() => _boardState();
}

class _boardState extends State<board> {

var dataset=[];


addData(var name,var title,var content,var num1,var image)
{
  var new_one=Data(name,title,content,num1,image);
  setState(() {
    dataset=[...dataset,new_one];
  });
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

  var board_name=["유저게시판","자유게시판"];
  
    final myController=TextEditingController();
    return Scaffold(
      appBar:AppBar(
        title: Text("게시판"),
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

      body: CustomScrollView(
          slivers:<Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10,
                childAspectRatio: 4,
              ),
              // SliverChildBuiilderDelegate는 ListView.builder 처럼 리스트의 아이템을 생성해줌
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  // 5

                  return Container(
                    alignment: Alignment.center,
                      color: Colors.teal[100 * (index+1 % 9)],
                      child: Text(board_name[index]),

                  );

                },
                // 6
                childCount: 2,
              ),),
            SliverFixedExtentList(
              itemExtent: 50.0,
delegate: SliverChildBuilderDelegate((BuildContext context,int index){
  return ListTile(
    leading: dataset[index].userImage!=null?Image.file(dataset[index].userImage):Text(""),
    title:Text(dataset[index].title),
    onTap : ()=>{

      Navigator.push(context,
          MaterialPageRoute(builder: (context) {
        return information(data:dataset[index]);
      }))
    },
    trailing: TextButton(
      child: Text('좋아요'),
      onPressed: (){
        setState(() {
          dataset[index].num++;
        });
      },
    ),
  );
},childCount: dataset.length),
    )])



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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextButton(child: Text("게시글 올리기"),onPressed: (){
        Navigator.pop(context,false);
      },
      ),actions: [

        TextButton(child: Text("hihi"),onPressed: (){},),
        IconButton(onPressed: (){
          print("여기야?");
          //name,title,content,따봉 위에서이미지로바꾸기
          if(userimage!=null) {
            print("hihi");
            widget.addData(
                "1", controllerTitle.text, controllerContent.text,1,userimage);
            print("add");
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
        TextButton(onPressed: (){

        }, child: Text("게시판을선택하세요                                                                   ▼",style: TextStyle(fontSize: 15,color: Colors.black,),)),

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
  const information({Key? key,this.data}) : super(key: key);
  final data;
  @override
  State<information> createState() => _informationState();
}

class _informationState extends State<information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: TextButton(child: Text("게시판"),onPressed: (){

    })
        ),
      body:CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("작성자 : "+widget.data.name),
                Text(""),
                Text(widget.data.title),
                widget.data.userImage!=null?Image.file(widget.data.userImage,width: 400,height: 400,):Text("")
              ],
            ) ,)
,
        ],
      ) ,
    );
  }
}
