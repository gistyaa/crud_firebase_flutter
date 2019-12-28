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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(children: <Widget>[
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: new NetworkImage(widget.user.photoUrl),
                fit: BoxFit.cover 
              ) 
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Selamat Datang", style: new TextStyle(fontSize: 17.0, color: Colors.blue),),
                new Text(widget.user.displayName, style: new TextStyle(fontSize: 20.0, color: Colors.black ),),
                  ],
                ),
          )
            ],
          ),
        ),
      ),
    );
  }
}