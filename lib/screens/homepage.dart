import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/screens/home_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  var user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User: ${user.currentUser!.email}"),
        actions: [
          IconButton(
            onPressed: () {
              user.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                    (route) => false);
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text("${user.currentUser!.uid}"),),
    );
  }
}
