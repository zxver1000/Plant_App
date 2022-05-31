
import 'package:flutter/material.dart';

class MakePlant extends StatefulWidget {
  const MakePlant({Key? key}) : super(key: key);

  @override
  State<MakePlant> createState() => _MakePlantState();
}

class _MakePlantState extends State<MakePlant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("식물 등록 테스트"),),
      body: Container(),
    );
  }
}
