import 'package:flutter/material.dart';

class MsgListview extends StatelessWidget {
  const MsgListview(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Text(message,)
        )
      ],
    );
  }
}