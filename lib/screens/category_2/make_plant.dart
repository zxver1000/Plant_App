
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';

class MakePlant extends StatefulWidget {
  const MakePlant({Key? key}) : super(key: key);

  static String routeName = "make_plant";

  @override
  State<MakePlant> createState() => _MakePlantState();
}

class _MakePlantState extends State<MakePlant> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;


  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  String plantName ='';
  String content ='';

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings;

    late String retriveString;

    if(data.arguments == null)
      retriveString = "empty";
    else
      retriveString = data.arguments as String;

    print(data);


    return Scaffold(
      appBar: AppBar(title: Text('식물 등록 화면'),
      backgroundColor: mainColor,),
      body:Container(

        child: Column(
        children: [
          SizedBox(height: 5,),
          Text("선택한 식물 : $retriveString",
          style: TextStyle(
            color: Colors.blueGrey,
            letterSpacing: 2.0,
            fontSize: 17.0,
            fontWeight: FontWeight.normal
          ),),
          SizedBox(height: 10,),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '식물 이름',

            ),
            onChanged: (value){
              setState(() {
                plantName = value;
              });
            },
          ),

          SizedBox(height: 10),

          TextField(
            controller: contentController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '내용',
            ),
            maxLines: 5,
            onChanged: (value){
              setState(() {
                content = value;
              });

            },
          ),
          ElevatedButton(
              onPressed: (){

                fireStore.collection('식물등록').doc().set({

                  "plant_name":plantName,
                  "content":content,

                });


              },
              child: Text('업로드 하기')
             ),



        ],
      ),
      ),
    );
  }
}
