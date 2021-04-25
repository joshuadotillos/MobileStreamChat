import 'package:flutter/material.dart';
import 'package:mobilestreamchat/model/userProfile.dart';

class ChatMessage extends StatefulWidget {
  final User user;
  ChatMessage({this.user});

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.name,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello " + widget.user.name,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
