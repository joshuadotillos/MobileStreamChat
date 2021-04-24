import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilestreamchat/net/api_methods.dart';
import 'package:mobilestreamchat/net/flutterfire.dart';
import 'package:mobilestreamchat/ui/add_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mobilestreamchat/ui/groupChat.dart';
import 'package:mobilestreamchat/ui/personalChat.dart';

int selectBottomIndex = 0;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double tether = 0.0;
  double ethereum = 0.0;

  @override
  void initState() {
    getValues();
  }

  getValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    setState(() {});
  }

  Widget build(BuildContext context) {
    String title() {
      if (selectBottomIndex == 0) {
        return 'Personal Chat';
      } else if (selectBottomIndex == 1) {
        return 'Group Chat';
      }
      return "";
    }

    void itemTapped(int index) {
      setState(() {
        selectBottomIndex = index;
      });
    }

    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "ethereum") {
        return ethereum * amount;
      } else {
        return tether * amount;
      }
    }

    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
          title: Text(
            title(),
          ),
        ),
      body: Center(
        child: (selectBottomIndex == 0) ? PersonalChat() : GroupChat(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddView(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar:
          bottomNavigationBar(context, selectBottomIndex, itemTapped),
    );
  }
}

//drawer menu
Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.zero,
          child: Container(
            color: Theme.of(context).accentColor,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Text(
                  'Stream Chat',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            'Personal Chat',
            style: Theme.of(context).textTheme.headline6,
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PersonalChat()));
          },
        ),
        ListTile(
          leading: Icon(Icons.group),
          title: Text(
            'Group Chat',
            style: Theme.of(context).textTheme.headline6,
          ),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => GroupChat()));
          },
        ),
      ],
    ),
  );
}

//bottomNavigationBar
Widget bottomNavigationBar(
    BuildContext context, int bottomIndex, Function tap) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('Personal Chat'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.group),
        title: Text('Group Chat'),
      ),
    ],
    currentIndex: bottomIndex,
    onTap: tap,
  );
}
