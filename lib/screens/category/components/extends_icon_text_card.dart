
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/models/list_category_menu.dart';
import 'package:plant_app/screens/category/components/round_border_text.dart';
import 'package:plant_app/screens/category/models/plant_detail.dart';

// 1
class ExtendsIconTextCard extends StatefulWidget {


  final ListCategoryMenu item;
  const ExtendsIconTextCard({Key? key, required this.item}) : super(key: key);
  @override
  _ExtendsIconTextCardState createState() => _ExtendsIconTextCardState(item);
}


class _ExtendsIconTextCardState extends State<ExtendsIconTextCard> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<PlantDetail> details = [];

  var name = "??";
  // 2
  _ExtendsIconTextCardState(this.item);
  // 3
  final ListCategoryMenu item;
  // 4
  bool isShow = false;
  // 5
  void toggle() {
    setState(() async{
      isShow = !isShow;


      var plant = await firestore.collection('Plants').doc('baby_apple').get();

     /* if (plant != null){
        details = plant.docs.map((document) =>
          PlantDetail.fromMap(document)).toList();
        int i = 0;
        details.forEach((detail) {

          detail.id = plant.docs[i].id;
          name = detail.id;
          i++;
        });
      }*/
      setState(() {
        name = plant['difficulty'];
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 12),
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(item.icon),
                ),
                const SizedBox(width: 35),
                Text(item.title),
                const Spacer(),
                SizedBox(
                  width: 30,
                  child: IconButton(
                    // 6
                    onPressed: () {
                      toggle();
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/down-arrow.svg",
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 7
          AnimatedContainer(

            duration: const Duration(milliseconds: 350),
            curve: Curves.fastOutSlowIn,
            height: isShow ? 100 : 0,
            decoration: BoxDecoration(color: Colors.blue[400]),
            child:
              Column(

                 mainAxisAlignment:MainAxisAlignment.center ,
                 children: [Text("${name}"), Text("${name}")],

          ),
               ),

        ],
      ),
    );
  }
}
