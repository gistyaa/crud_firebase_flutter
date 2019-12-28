import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'myProject.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Firebase Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}
 class MyHomePage extends StatefulWidget {
   @override
   _MyHomePageState createState() => _MyHomePageState();
 }
 
 class _MyHomePageState extends State<MyHomePage> {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
   final FirebaseUser user = await _auth.signInWithCredential(credential);
     Navigator.of(context).push(
     new MaterialPageRoute(
       builder:(BuildContext context)=> new MyProject(
         user:user,
         googleSignIn:googleSignIn)
     )
    );
   }
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/BackgroundLogin.jpg"), 
            fit: BoxFit.cover 
          )  
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            new Image.asset("assets/images/logo.png",height: 150.0,width : 150.0,),
            new Padding(padding: EdgeInsets.only(top: 10),),
            new InkWell(
              onTap: (){
                signInWithGoogle();
              },
              child: new Image.asset(
                "assets/images/signin.png",
                height: 60.0,
                width : 150.0,)),
          ],),
        ),
      ), 
    );
  }
}