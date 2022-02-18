import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class SignUp {
  final FirebaseAuth _authUser = FirebaseAuth.instance;

  Future<bool> signup(context, e , p) async {
    try {
      UserCredential _credential =
          await _authUser.createUserWithEmailAndPassword(email: e, password: p);
      User? _user = _credential.user;
      debugPrint("User: ${_user!.email}");
      return true;
    } catch (e) {
      print("$e");
      return false;
    }
  }
}
