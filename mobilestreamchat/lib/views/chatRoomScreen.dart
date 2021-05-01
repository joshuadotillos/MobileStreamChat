//EDITED BY ROSIE
import 'package:flutter/material.dart';
import 'package:mobilestreamchat/helper/authenticate.dart';
import 'package:mobilestreamchat/helper/constants.dart';
import 'package:mobilestreamchat/helper/helperfunctions.dart';
import 'package:mobilestreamchat/services/auth.dart';
import 'package:mobilestreamchat/services/database.dart';
import 'package:mobilestreamchat/views/chat/conversationScreen.dart';
import 'package:mobilestreamchat/views/search.dart';

int selectBottomIndex = 0;

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ChatRoomsTile(
                        snapshot.data.docs[index]
                                    .data()["users"][0]
                                    .toString() ==
                                Constants.myName
                            ? snapshot.data.docs[index]
                                .data()["users"][1]
                                .toString()
                            : snapshot.data.docs[index]
                                .data()["users"][0]
                                .toString(),
                        snapshot.data.docs[index].data()["chatroomId"]);
                  })
              : Container();
        });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFuntions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: Text(
          "Stream Chat",
        ),
      ),
      body: chatRoomList(),
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

//drawer
Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.zero,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Align(
              alignment: Alignment.centerLeft,
              child: UserAccountsDrawerHeader(
                accountEmail: FittedBox(
                  child: Text(
                    "email@email.com",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                accountName: FittedBox(
                  child: Text(
                    "USERNAME",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  //backgroundImage: AssetImage(currentUser.imageUrl),
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Sign Out',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
            ),
          ),
        ),
      ],
    ),
  );
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoomId)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              alignment: Alignment.center,
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(40)),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: TextStyle(fontSize: 14.0, fontFamily: "Raleway"),
            )
          ],
        ),
      ),
    );
  }
}
