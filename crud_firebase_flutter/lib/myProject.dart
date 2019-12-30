//import 'dart:asyn';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crud_firebase_flutter/addProject.dart';

class MyProject extends StatefulWidget {
  MyProject({this.user, this.googleSignIn});

  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  @override
  _MyProjectState createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  void _signOut() {
    AlertDialog alertDialog = new AlertDialog(
      content: Container(
        height: 250.0,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: new Image.network(widget.user.photoUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "SignOut ?",
                style: new TextStyle(fontSize: 16.0),
              ),
            ),
            new Divider(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    widget.googleSignIn.signOut();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new MyHomePage()));
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.check),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      Text("Yes")
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.close),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      Text("No")
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new AddProject(
                    email: widget.user.email,
                  )));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        elevation: 20.0,
        color: Colors.blue,
        child: ButtonBar(
          children: <Widget>[],
        ),
      ),
      body: new Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 210.0),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection("task")
                  .where("email", isEqualTo: widget.user.email)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                return new ProjectList(
                  document: snapshot.data.documents,
                );
              },
            ),
          ),
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: new AssetImage("assets/images/bghome.jpg"),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: new NetworkImage(widget.user.photoUrl),
                                fit: BoxFit.cover)),
                      ),
                      new Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "Selamat Datang",
                                style: new TextStyle(
                                    fontSize: 17.0, color: Colors.blue),
                              ),
                              new Text(
                                widget.user.displayName,
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new IconButton(
                        icon: Icon(Icons.exit_to_app,
                            color: Colors.black, size: 30.0),
                        onPressed: () {
                          _signOut();
                        },
                      )
                    ],
                  ),
                ),
                new Image.asset(
                  "assets/images/logo.png",
                  height: 60.0,
                  width: 150.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectList extends StatelessWidget {
  ProjectList({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String title = document[i].data['title'].toString();

        return Text(title);
      },
    );
  }
}
