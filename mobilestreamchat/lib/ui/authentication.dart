import 'package:mobilestreamchat/net/flutterfire.dart';
import 'package:mobilestreamchat/ui/home_view.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Stream Chat!",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _emailField,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Email",
                    labelStyle:
                        TextStyle(color: Colors.white, fontFamily: "Raleway"),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 60,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordField,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Password",
                    labelStyle:
                        TextStyle(color: Colors.white, fontFamily: "Raleway"),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await register(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 60,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await signIn(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
