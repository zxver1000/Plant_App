import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/notification.dart';
import 'package:intl/intl.dart';
class RegisterPlant extends StatefulWidget {
  const RegisterPlant({Key? key}) : super(key: key);

  static String routeName = "make_plant";

  @override
  State<RegisterPlant> createState() => _RegisterPlantState();
}

class _RegisterPlantState extends State<RegisterPlant> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController watercycleController = TextEditingController();

  String plantName ='';
  String content ='';
  String water_cycle = '';
  DateTime now = DateTime.now();
  DateTime nowTime = DateTime.parse(DateTime.now().toString().substring(0,10) + " 00:00:00.000Z");
 var times;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String formatDate = DateFormat('yyyy-MM-dd').format(now);
    times=formatDate;
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('식물 등록 화면'),
        backgroundColor: mainColor,),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 5,),
            /*Text("선택한 식물 : $retriveString",
              style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontSize: 17.0,
                  fontWeight: FontWeight.normal
              ),),*/
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
              maxLines: 3,
              onChanged: (value){
                setState(() {
                  content = value;
                }
                );

              },
            ),

            SizedBox(height: 5,),

            TextField(
              controller: watercycleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '물주기 선택',
              ),
              maxLines: 1,
              onChanged: (value){
                setState(() {
                  water_cycle = value;
                }
                );

              },
            ),
            ElevatedButton(
                onPressed: (){

                  fireStore.collection('식물등록').add({

                    "plant_name":plantName,
                    "content":content,
                    "water_cycle":water_cycle,
                    "water_checking":0,
                    "time":times,

                  });
                  showNotification();
                  Navigator.pop(context);
                },
                child: Text('업로드 하기')
            ),



          ],
        ),
      ),
    );
  }
}
