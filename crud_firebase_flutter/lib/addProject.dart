import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProject extends StatefulWidget {
  AddProject({this.email});
  final String email;
  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  DateTime _dueDate = new DateTime.now();
  String _dateText='';

  String newTask='';
  String note='';

  Future<Null> _selectedDueDate(BuildContext context) async{
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2080)
      );
 
  if(picked != null){
    setState((){
      _dueDate=picked;
      _dateText= "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";
    });
  }
}

void _addData(){
 Firestore.instance.runTransaction((Transaction transsaction) async{
    CollectionReference reference = Firestore.instance.collection('task');
    await reference.add({
      "email" : widget.email,
      "title" : newTask,
      "duedate" : _dateText,
      "note" : note,
    });
  });
  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bghome.jpg"),
                fit: BoxFit.cover)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 60.0,
                    width: 150.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Text("Add Project", style: new TextStyle(fontSize:24.0,
                    color:Colors.black)),
                ),
                 Icon(Icons.list,color:Colors.black,size:30.0)
              ],
            )
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new TextField(
              onChanged: (String str){
                setState(() {
                  newTask =str;
                });
              },
              decoration: new InputDecoration(
                icon: Icon(Icons.dashboard),
                hintText: "New Task",
                border: InputBorder.none
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right:15.0),
                  child: new Icon(Icons.date_range),
                ),
                new Expanded(child: Text("Due Date", style: new TextStyle(fontSize: 15.0, color:Colors.grey),)),
                new FlatButton(
                  onPressed: ()=>_selectedDueDate(context),
                  child: Text(_dateText, style: new TextStyle(fontSize: 15.0, color:Colors.grey),)),
              ],),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new TextField(
              onChanged: (String str){
                setState(() {
                  note =str;
                });
              },
              decoration: new InputDecoration(
                icon: Icon(Icons.note),
                hintText: "Note",
                border: InputBorder.none
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[  
              IconButton(
                icon: Icon(Icons.check, size:40.0),
                onPressed: (){
                  _addData();
                },
              ),
              IconButton(
                icon: Icon(Icons.close, size:40.0),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],),
          )
        ],
      ),
    );
  }
}