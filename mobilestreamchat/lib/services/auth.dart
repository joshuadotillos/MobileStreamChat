//EDITED BY ROSIE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilestreamchat/modal/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserClass _userFromFirebaseUser(User user) {
    return user != null ? UserClass(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}

class UserNameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 3) {
      return "Name must be at least 3 characters";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters";
    }
    if (value.indexOf(' ') >= 0) {
      return "Contains spaces";
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)
        ? null
        : "Enter valid email";
  }
}

class PasswordValidator {
  static String validate(String value) {
    return value.length < 4 ? "Enter a Stronger Password" : null;
  }
}
