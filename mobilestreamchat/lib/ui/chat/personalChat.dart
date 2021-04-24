import 'package:flutter/material.dart';

class PersonalChat extends StatefulWidget {
  @override
  _PersonalChatState createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Hello Personal Chat')],
      ),
    );
  }
}
