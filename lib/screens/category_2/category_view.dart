
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/category_2/category_view_model.dart';
import 'package:plant_app/screens/category_2/state/tabbar_change.dart';
import 'package:plant_app/screens/category_2/widget/category_card.dart';
import 'package:provider/provider.dart';






class CategoryView extends CategoryViewModel {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('카테고리별 선택'),
        backgroundColor: mainColor,),
      body: buildChangeBody(),
    );
  }

  ChangeNotifierProvider<TabBarChange> buildChangeBody() {
    return ChangeNotifierProvider.value(
      value: tabBarNotifier,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: buildListViewHeader),
          Divider(),
          Expanded(flex: 9, child: buildListViewPlant),
        ],
      ),
    );
  }

  ListView get buildListViewPlant {
    return ListView.builder(
      controller: scrollController,
      itemCount: plantListAndSpaceAreaLength,
      itemBuilder: (context, index) {
        print(index);
        if (index == plantListLastIndex)
          return emptyWidget;
        else
          return CategoryCard(
              model: plantList[index],
              index: index,
              onHeight: (val) {
                fillListPositionValues(val);
              }// , key: null,
          );
      },
    );
  }


  int get plantListAndSpaceAreaLength => plantList.length + 1;

  int get plantListLastIndex => plantList.length;

  Container get emptyWidget => Container(height: oneItemHeight * 2);

  Widget get buildListViewHeader {
    return Consumer<TabBarChange>(
      builder: (context, value, child) => ListView.builder(
        itemCount: plantList.length,

        controller: headerScrollController,
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => buildPaddingHeaderCard(index),
      ),
    );
  }

  Padding buildPaddingHeaderCard(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style:ElevatedButton.styleFrom(primary: Colors.teal[50],
            shape: StadiumBorder()),
        onPressed: () => headerListChangePosition(index),
        child: Text("${plantList[index].categoryName} $index",
          style: TextStyle(color: Colors.black45),),

      ),
    );
  }
}