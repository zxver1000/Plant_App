import 'package:flutter/material.dart';

class ProfileCountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildInfo("5", "Plants"),
        _buildLine(),
        _buildInfo("1", "Posts"),

      ],
    );
  }

  Widget _buildInfo(String count, String title) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(height: 2),
        Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildLine() {
    return Container(width: 2, height: 30, color: Colors.blue);
  }
}