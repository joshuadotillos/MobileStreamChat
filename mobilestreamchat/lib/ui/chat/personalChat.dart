import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:mobilestreamchat/model/messageDummy.dart';
import 'package:mobilestreamchat/model/search.dart';

class PersonalChat extends StatefulWidget {
  @override
  _PersonalChatState createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    if (search == "empty") return [];
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SearchBar<Post>(
        onSearch: search,
        onItemFound: (Post post, int index) {
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.description),
          );
        },
        emptyWidget: Center(
          child: Text("Empty"),
        ),
        hintText: "Search Name",
        textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Raleway"),
        searchBarStyle: SearchBarStyle(
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        header: Column(
          children: [
          ],
        ),
      ),
    ));
  }
}
