class CategoryModel {


  final String categoryName;
  final List<Plant> plants;
  double position = 0;

  CategoryModel({required this.categoryName, required this.plants});
}

class Plant {
  final String name;
  final int price;

  Plant(this.name, this.price);
}
