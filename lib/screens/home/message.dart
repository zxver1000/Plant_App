import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'msg_listview.dart';

class Message extends StatelessWidget {
  Message(this.selectedDay, {Key? key}) : super(key: key);

  String selectedDay;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final eventDocs = snapshot.data!.docs;
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: eventDocs.length,
            itemBuilder: (context, index){
              return MsgListview(
                 eventDocs[index]['Title'],
                //eventDocs[index]['userID'].toString() == user!.uid
              );
              },
        );
        //MsgListview(
          //2022-05-09T00:00:00.000Z: 
          //eventDocs[0]['id'],
        //);
      },
    );
    
  }
}