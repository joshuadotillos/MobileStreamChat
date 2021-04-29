import 'package:flutter/material.dart';
import 'package:mobilestreamchat/chat/recent_chats.dart';

class PersonalChat extends StatefulWidget {
  @override
  _PersonalChatState createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          RecentChats(),
        ],
      ),
    );
  }
}