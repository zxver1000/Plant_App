class ListCategoryMenu {
  String icon;
  String title;

  ListCategoryMenu({required this.icon, required this.title});

}

// 샘플 데이터
List listCategoryMenuList = [
  ListCategoryMenu(
    icon: "assets/icons/menu-button-svgrepo-com.svg",
    title: "계절",

  ),
  ListCategoryMenu(
    icon: "assets/icons/menu-button-svgrepo-com.svg",
    title: "장소",

  ),
  ListCategoryMenu(
    icon: "assets/icons/menu-button-svgrepo-com.svg",
    title: "목적"
  ),
  ListCategoryMenu(
    icon: "assets/icons/menu-button-svgrepo-com.svg",
    title: "난이도"
  ),

];
