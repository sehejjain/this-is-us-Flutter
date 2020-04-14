import 'package:flutter/material.dart';

import '../constants.dart';

class TextCard extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType keyboard;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: TextField(
          onChanged: onChange,
          keyboardType: keyboard,
          style: TextStyle(
            color: Colors.teal.shade900,
            fontSize: 20.0,
            fontFamily: 'Source Sans Pro',
          ),
          decoration: kTextFieldDecoration.copyWith(hintText: hintText),
        ),
      ),
    );
  }

  TextCard({this.hintText, this.icon, this.keyboard, this.onChange});
}
