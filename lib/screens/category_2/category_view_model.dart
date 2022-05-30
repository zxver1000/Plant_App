import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/screens/category_2/category.dart';
import 'package:plant_app/screens/category_2/model/category_helper.dart';
import 'package:plant_app/screens/category_2/model/category_model.dart';
import 'package:plant_app/screens/category_2/state/tabbar_change.dart';


abstract class CategoryViewModel extends State<Category> {
  ScrollController scrollController = ScrollController();
  int currentCategoryIndex = 0;
  ScrollController headerScrollController = ScrollController();

  List<CategoryModel> plantList = [];

  var categories = ["계절","난이도","장소"];

  @override
  void initState() {
    super.initState();

    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    var  name = "??";
    List<Map> plantDbList ;

    plantList = List.generate(
          3,
          (index) => CategoryModel(
        // 카테고리 정보
            categoryName: "${categories[index]}",

        // 식물 정보 넣기
        plants: List.generate(
          6,
              (index) => Plant("Plant $index", index * 100),
        ),
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
