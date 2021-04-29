//EDITED BY ROSIE
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text("Stream Chat"),
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(hintText: hintText);
}

TextStyle simpleTextStyle() {
  return TextStyle(fontSize: 15.0);
}

TextStyle mediumTextStyle() {
  return TextStyle(fontSize: 13.0);
}
