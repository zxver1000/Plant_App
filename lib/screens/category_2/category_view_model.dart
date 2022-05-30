import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/screens/category_2/category.dart';
import 'package:plant_app/screens/category_2/model/category_helper.dart';
import 'package:plant_app/screens/category_2/model/category_model.dart';
import 'package:plant_app/screens/category_2/plant_lists.dart';
import 'package:plant_app/screens/category_2/state/tabbar_change.dart';


abstract class CategoryViewModel extends State<Category> {
  ScrollController scrollController = ScrollController();
  int currentCategoryIndex = 0;
  ScrollController headerScrollController = ScrollController();

  List<CategoryModel> plantList = [];

  var categories = ["봄","여름","가을","겨울","난이도-하","난이도-중","난이도-상","실내","실외","관상용","식용"];

  @override
  void initState() async{
    super.initState();

    var  name = "??";
    List<Map> plantDbList ;

    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    DocumentSnapshot test = await fireStore.collection('Plants').doc('baby_apple').get();
    name = test['season'];
    print(name);


/*
    List<Plant> plant_list1 = [
      Plant("apple", 2000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),Plant("lemon", 3000),
      Plant("lemon", 3000),Plant("lemon", 3000),
    Plant("lemon", 3000),Plant("lemon", 3000),Plant("lemon", 3000),
      Plant("lemon", 3000),Plant("lemon", 3000),Plant("lemon", 3000),
      Plant("lemon", 3000),Plant("lemon", 3000),Plant("lemon", 3000),

    ];

    List<Plant> plant_list2 = [
      Plant("apple2", 2000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),
      Plant("lemon", 3000),Plant("lemon", 3000),
      Plant("lemon", 3000),Plant("lemon", 3000),
      Plant("lemon", 3000),Plant("lemon", 3000),Plant("lemon", 3000),
      Plant("lemon", 3000),Plant("lemon", 3000),Plant("lemon", 3000),
      Plant("lemon", 3000),Plant("lemon", 3000),Plant("lemon", 3000),

    ];

 */

    List plant_lists = [plant_list1 ,plant_list2, plant_list3, plant_list4, plant_list5, plant_list6,plant_list7,plant_list8,plant_list9,plant_list10, plant_list11];

    plantList = List.generate(
          11,
          (index) => CategoryModel(
        // 카테고리 정보
            categoryName: "${categories[index]}",

        // 식물 정보 넣기
           plants: plant_lists[index]/* List.generate(
          6,
              (index) => Plant("Plant $index", index * 100),
        ),*/
      ),
    );

    scrollController.addListener(() {
      final index = plantList
          .indexWhere((element) => element.position >= scrollController.offset);
      tabBarNotifier.changeIndex(index);

      headerScrollController.animateTo(
          index * (MediaQuery.of(context).size.width * 0.2),
          duration: Duration(seconds: 1),
          curve: Curves.decelerate);
    });
  }

  void headerListChangePosition(int index) {
    scrollController.animateTo(plantList[index].position,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  double oneItemHeight = 0;

  void fillListPositionValues(double val) {
    if (oneItemHeight == 0) {
      oneItemHeight = val;
      plantList.asMap().forEach((key, value) {
        if (key == 0) {
          plantList[key].position = 0;
        } else {
          plantList[key].position = getPlantListPosition(val, key);
        }
      });
    }
  }

  double getPlantListPosition(double val, int index) =>
      val * (plantList[index].plants.length / CategoryHelper.GRID_COLUMN_VALUE) +
          plantList[index - 1].position;
}
