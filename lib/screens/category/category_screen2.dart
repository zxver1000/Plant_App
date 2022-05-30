import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/screens/category/models/plant_detail.dart';

class CategoryScreen2 extends StatelessWidget {

  final String uid;
  CategoryScreen2(this.uid);
  //const CategoryScreen2({Key? key}) : super(key: key);


  /*Future testData() async{
   /* await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;

    var data = await db.collection('Plants').get();
    var details = data.docs.toList();

    details.forEach((d){
      print(d.id);
    });
*/
  }
*/



 

  @override
  Widget build(BuildContext context) {
  //testData();

    return Scaffold(
        appBar: AppBar(
          title: Text('Event'),
        ),
      body: PlantList(uid),

    );
  }
}

class PlantList extends StatefulWidget {
  final String uid ;

  PlantList(this.uid) {
   Firebase.initializeApp();
  }

  @override
  _PlantListState createState() => _PlantListState();

}

class _PlantListState extends State<PlantList> {

  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<PlantDetail> details = [];

  @override
  void initState() {
    if (mounted) {
      getDetailsList().then((data) {
        setState(() {
          details = data;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (details != null) ? details.length : 0,
      itemBuilder: (context, position) {
        String sub = 'Date: ${details[position].isFavorite} - Start : ' +
            '${details[position].difficulty}';
        return ListTile(
          title: Text(details[position].place),
          subtitle: Text(sub),
        );
      },

    );
  }

  Future<List<PlantDetail>> getDetailsList() async {
    var data = await db.collection('Plants').get();

    if (data != null) {
      details = data.docs.map((document) =>
          PlantDetail.fromMap(document)).toList();
      int i = 0;
      details.forEach((detail) {
        detail.id = data.docs[i].id;
        i++;
      });
    }
    return details;
  }



}
