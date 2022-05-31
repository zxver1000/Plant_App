class CategoryModel {


  final String categoryName;
  final List<Plant> plants;
  double position = 0;

  CategoryModel({required this.categoryName, required this.plants});
}

class Plant {
  final String name;
  final String place;
  final String difficulty;
  final String use;
  final int water_cycle;

  Plant(this.name, this.place, this.difficulty, this.use, this.water_cycle);
}
