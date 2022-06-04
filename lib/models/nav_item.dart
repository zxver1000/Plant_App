class NaveItem {
final int id;
final String icon;
final String label;

// argument를 {}로 묶으면 이제 선택사항으로 바뀜. 아예 입력 안 해도 됨
NaveItem({required this.label, required this.id, required this.icon});


}

List<NaveItem> navItems = [
NaveItem(label: "홈", id: 0, icon: "assets/icons/home.svg"),
 // NaveItem(label: "추천", id: 1, icon: "assets/icons/star.svg"),
  NaveItem(label: "레시피" , id:1, icon: "assets/icons/square.svg"),
  NaveItem(label: "카테고리", id: 2, icon: "assets/icons/loupe.svg"),
  NaveItem(label: "게시판", id: 3, icon: "assets/icons/board.svg"),
  NaveItem(label: "마이페이지", id: 4, icon: "assets/icons/user.svg")

];
