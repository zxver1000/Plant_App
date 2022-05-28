import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  var name = "??";

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(child: _buildTabBarView()),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: [
        Tab(
            icon: Icon(
              Icons.favorite,
            )),
        Tab(
            icon: Icon(
              Icons.favorite_border,
            )),
      ],
    );
  }

  Widget _buildTabBarView() {

    return TabBarView(


      controller: _tabController,
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            crossAxisCount: 3,
            mainAxisSpacing: 10,
          ),

          itemCount: 40,

          itemBuilder: (context, index) {
            return Container(
              color: Colors.lightGreen,

              child: Text(' Item : $index'),

            );
          },
        ),
        Container(color: Colors.red),
      ],
    );
  }
}