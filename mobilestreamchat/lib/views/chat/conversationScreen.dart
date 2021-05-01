//EDITED BY ROSIE
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobilestreamchat/helper/constants.dart';
import 'package:mobilestreamchat/services/database.dart';
import 'package:mobilestreamchat/widgets/widget.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream chatMessageStream;

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.docs[index].data()["message"],
                      snapshot.data.docs[index].data()["sendBy"] ==
                          Constants.myName);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      DatabaseMethods().addConversationMessages(widget.chatRoomId, messageMap);
      setState(() {
        messageController.text = "";
      });
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversation Screen"),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: Colors.grey,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //to be edit for image attachment
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(40)),
                          child: Image.asset("assets/images/imageIconWhite.png")),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                        child: TextField(
                      controller: messageController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Message.",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none),
                    )),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(40)),
                          child: Image.asset("assets/images/send.png")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            color: isSendByMe ? Colors.indigo : Colors.black,
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        child: Text(
          message,
          style: TextStyle(
              fontSize: 17.0, fontFamily: "Raleway", color: Colors.white),
        ),
      ),
    );
  }
}
