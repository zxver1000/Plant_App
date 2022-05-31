
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';

class MakePlant extends StatefulWidget {
  const MakePlant({Key? key}) : super(key: key);

  static String routeName = "make_plant";

  @override
  State<MakePlant> createState() => _MakePlantState();
}

class _MakePlantState extends State<MakePlant> {
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
      body: Column(
        children: [
          Text("Test page"),
          Text("Got a data - $retriveString"),
        ],
      )
    );
  }
}
