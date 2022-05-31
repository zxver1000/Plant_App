import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  late TabController _tabController;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  var plant_name ='';
  var content ='';


  @override
  void initState() {

    /*DocumentSnapshot test = fireStore.collection('식물등록').doc('user1').get();
    setState(() {
      plant_name = test['name'];
    });
*/
    _tabController = TabController (
      length: 2,
      vsync: this,
      //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
        //title: Text(
         // 'TabPage',

      //  ),
      //  toolbarHeight: 20,
     // ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: TabBar(
              tabs: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    '내 식물',
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    '내가 쓴 글',
                  ),
                ),
              ],
              indicator: BoxDecoration(
                gradient: LinearGradient(  //배경 그라데이션 적용
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blueAccent,
                    Colors.pinkAccent,
                  ],
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              controller: _tabController,
            ),
          ),
          Expanded(
            child: TabBarView(

              controller: _tabController,
              children: [
                Container(
                  color: Colors.yellow[200],
                  alignment: Alignment.center,
                  child: Text(plant_name,
                  style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  color: Colors.green[200],
                  alignment: Alignment.center,
                  child: Text(
                    'Tab2 View',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}