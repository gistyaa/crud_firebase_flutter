import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyProject extends StatefulWidget {
  MyProject({this.user,this.googleSignIn});

  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  @override
  _MyProjectState createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 170.0,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: new AssetImage("assets/images/bghome.jpg"),
            fit: BoxFit.cover,
          ) 
        ),
      ),
    );
  }
}