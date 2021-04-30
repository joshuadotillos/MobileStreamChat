//EDITED BY ROSIE
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:mobilestreamchat/helper/helperfunctions.dart';
import 'package:mobilestreamchat/services/auth.dart';
import 'package:mobilestreamchat/services/database.dart';
import 'package:mobilestreamchat/views/chatRoomScreen.dart';
import 'package:mobilestreamchat/widgets/widget.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn() {
    if (formKey.currentState.validate()) {
      HelperFuntions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      databaseMethods
          .getUserbyUserEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFuntions.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0].data()["name"]);
        // print("${snapshotUserInfo.docs[0].data()["name"]}this is not good");
      });

      setState(() {
        isLoading = true;
      });
      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        if (val != null) {
          HelperFuntions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 90,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                              ? null
                              : "Enter valid email";
                        },
                        controller: emailTextEditingController,
                        decoration: textFieldInputDecoration("Email"),
                        style: simpleTextStyle(),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          return val.length < 4 ? "Wrong Password" : null;
                        },
                        controller: passwordTextEditingController,
                        decoration: textFieldInputDecoration("Password"),
                        style: simpleTextStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Sign In with Google",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: mediumTextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Register now",
                          style: mediumTextStyle(),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
