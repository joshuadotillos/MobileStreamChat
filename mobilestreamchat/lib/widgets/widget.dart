//EDITED BY ROSIE
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text("Stream Chat"),
    automaticallyImplyLeading: false,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(hintText: hintText);
}

TextStyle simpleTextStyle() {
  return TextStyle(fontSize: 16.0, fontFamily: "Raleway");
}

TextStyle mediumTextStyle() {
  return TextStyle(fontSize: 14.0, fontFamily: "Raleway");
}
