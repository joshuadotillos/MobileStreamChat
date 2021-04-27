import 'package:flutter/material.dart';
import 'package:mobilestreamchat/ui/home_view.dart';

class NewDirectMessage extends StatefulWidget {
  @override
  _NewDirectMessageState createState() => _NewDirectMessageState();
}

class _NewDirectMessageState extends State<NewDirectMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Direct Message'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeView())),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Hello Direct Message'),
        ],
      ),
    );
  }
}
