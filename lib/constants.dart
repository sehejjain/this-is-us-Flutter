import 'package:flutter/material.dart';
import 'package:thisisus/services/size_config.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  border: InputBorder.none,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//  border: OutlineInputBorder(
//    borderRadius: BorderRadius.all(Radius.circular(32.0)),
//  ),
//  enabledBorder: OutlineInputBorder(
//    borderSide: BorderSide(color: Colors.blueAccent, width: 0),
//    borderRadius: BorderRadius.all(Radius.circular(0)),
//  ),
//  focusedBorder: OutlineInputBorder(
//    borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
//  ),
);


////Context Size
//class SizeConstantClass
//{
//  static double getBlockHorizontal(BuildContext context)
//  {
//    SizeConfig().init(context);
//    return SizeConfig.blockSizeHorizontal;
//  }
//  static double getBlockVertical(BuildContext context)
//  {
//    SizeConfig().init(context);
//    return SizeConfig.blockSizeVertical;
//  }
//}

