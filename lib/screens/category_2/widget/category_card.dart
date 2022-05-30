
import 'package:flutter/material.dart';
import 'package:plant_app/screens/category_2/model/category_helper.dart';
import 'package:plant_app/screens/category_2/model/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel model;
  final int index;
  final Function(double val) onHeight;

  const CategoryCard({Key? key, required this.model, required this.index, required this.onHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      onHeight((context.size!.height) /
          (model.products.length / CategoryHelper.GRID_COLUMN_VALUE));
    });
    return Column(
      children: [
        Divider(),
        Text("${model.categoryName} $index"),
        Card(
          child: buildGridViewProducts(index, model.products),
        ),
      ],
    );
  }

  GridView buildGridViewProducts(int index, List<Product> products) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: CategoryHelper.GRID_COLUMN_VALUE),
      itemBuilder: (context, index) {
        return Card(
          child: Text(products[index].name),
        );
      },
    );
  }
}
