import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.0),
        Icon(Icons.chevron_left, size: 40.0,),
        Spacer(),
        Icon(Icons.laptop),
        SizedBox(width: 10.0),
        Icon(Icons.headset),
        SizedBox(width: 10.0),
        Icon(Icons.mobile_screen_share),
        SizedBox(width: 10.0),
      ],
    );
  }
}