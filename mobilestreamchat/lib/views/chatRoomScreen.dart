//EDITED BY ROSIE
import 'package:flutter/material.dart';
import 'package:mobilestreamchat/helper/authenticate.dart';
import 'package:mobilestreamchat/services/auth.dart';
import 'package:mobilestreamchat/views/search.dart';
import 'package:mobilestreamchat/views/signin.dart';
import 'package:mobilestreamchat/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMenthods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Chat"),
        actions: [
          GestureDetector(
            onTap: () {
              authMenthods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}
