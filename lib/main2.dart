import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final firestore=FirebaseFirestore.instance;

class Main2 extends StatefulWidget {
  const Main2({Key? key}) : super(key: key);

  @override
  _Main2State createState() => _Main2State();
}

class _Main2State extends State<Main2> {

  var name='gd';
  /*디비데이터 꺼내기*/
  getData() async{
   var result=await firestore.collection('product1').get();
   name=result.docs[0]['name'];
   for(var name in result.docs){
     print(name['name']);
   }

  //데이터넣기
    //   await firestore.collection('product1').add({name:'금금금'});
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name),
    );
  }
}
