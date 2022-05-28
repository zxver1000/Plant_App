import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  var name = "??";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFollowButton(),
        _buildMessageButton(),
      ],
    );
  }

  Widget _buildFollowButton() {
    return InkWell(
      onTap: () async {
        DocumentSnapshot plant = await fireStore.collection('Plants').doc(
            'baby_apple').get();
        name = plant['name'];
        // print(plant.id);
        //print("등급");
        print(name);
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 35,
        child: Text(
          '내 식물',
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }


  Widget _buildMessageButton() {
    return InkWell(
      onTap: () async {
        print("내 게시물들");
        DocumentSnapshot plant = await fireStore.collection('Plants').doc(
            'baby_apple').get();
        print(plant.id);
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 35,
        child: Text(
          "내 게시물",
          style: TextStyle(color: Colors.black),
        ),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
        ),
      ),
    );
  }
}