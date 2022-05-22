import 'package:flutter/material.dart';

import 'components/profile_buttons.dart';
import 'components/profile_count_info.dart';
import 'components/profile_header.dart';
import 'components/profile_tab.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("마이 페이지")

      ),

      body: Column(
        children: [
          SizedBox(height: 20),
          ProfileHeader(),
          SizedBox(height: 20),
          ProfileCountInfo(),
          SizedBox(height: 20),
          ProfileButtons(),
          Expanded(child: ProfileTab()),
        ],
      ),
    );
  }
}
