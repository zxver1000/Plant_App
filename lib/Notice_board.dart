
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

    final myController=TextEditingController();
    return Scaffold(
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

      body: dataset.isNotEmpty==true?ListView.builder(
          itemCount: dataset.length,
          itemBuilder: (context,i){
            return ListTile(
              leading: dataset[i].userImage!=null?Image.file(dataset[i].userImage):Text(""),
              title:Text(dataset[i].title),
              trailing: TextButton(
                child: Text('좋아요'),
                onPressed: (){
                  setState(() {
                    dataset[i].num++;
                  });
                },
              ),
            );
          }):Text(""),
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
      appBar: AppBar(title: TextButton(child: Text("←"),onPressed: (){
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
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,children: [
        Text("")
        ,
        TextButton(onPressed: (){

        }, child: Text("게시판을선택하세요                                                                   ▼",style: TextStyle(fontSize: 15,color: Colors.black,),)),

        TextField(controller: controllerTitle,decoration: InputDecoration(hintText: "제목"),style: TextStyle(fontSize: 20),)
        ,TextField(controller: controllerContent,style: TextStyle(fontSize: 15),maxLines: 10,
        decoration: InputDecoration(border: InputBorder.none,hintText: "내용을 입력하세요!"),)
     ,
 userimage!=null?Image.file(userimage,width: 200,height: 100,):Text("")
        ],),
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

