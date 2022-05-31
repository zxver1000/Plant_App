import 'package:flutter/material.dart';

class ProfileMyPlant extends StatefulWidget {
  const ProfileMyPlant({Key? key}) : super(key: key);

  @override
  State<ProfileMyPlant> createState() => _ProfileMyPlantState();
}

class _ProfileMyPlantState extends State<ProfileMyPlant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Text("확인")
          ],
        ),
      ),
    );
  }
}
