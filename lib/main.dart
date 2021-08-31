import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login.dart';


FirebaseAuth auth = FirebaseAuth.instance;

final databaseReference = FirebaseDatabase.instance.reference();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}




class nik extends StatefulWidget {


  @override
  _nikState createState() => _nikState();
}

bool Tube_Light = true;
void createRecord() {
  databaseReference
      .child("onwords")
      .set({'Tube_Light': false, 'state': 'online', 'deviceCount': 22});
}

bool getData() {
  var Tube_Light = true;
  var a = databaseReference.once().then((DataSnapshot snapshot) {
    var data = snapshot.value;

    Tube_Light = data['onwords']['Tube_Light'];

    print(data);
    return Tube_Light;
    return Tube_Light;
  });
  print("a= $a");
  print("return befor value $Tube_Light");
  return Tube_Light;
}

class _nikState extends State<nik> {
  @override
  void initState() {
    print("init state>>>>>>>");
    super.initState();
  }

  @override
  final textcontroller = TextEditingController();
  var retrievedName = "dummy";
  Widget build(BuildContext context) {
    bool Tube_Light = true;

    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: RaisedButton(
              child: Text('Create Record'),
              onPressed: () {
                createRecord();
                databaseReference.child('users').set({'age': 22});
              },
            ),
          ),
          RaisedButton(
            child: Text('View Record'),
            onPressed: () {
              print("geting the data");

              var tb = getData();
              setState(() {
                Tube_Light = tb;
                print("tube light = $Tube_Light");
              });
            },
          ),
          RaisedButton(
              child: Text("update"),
              onPressed: () {
                print("geting the data");
                databaseReference.child('users').update({'age': 40});
              }),
          RaisedButton(
              child: Text("delete"),
              onPressed: () {
                databaseReference.child('').remove();
              }),
          ElevatedButton(
            onPressed: () {
              databaseReference
                  .child("onwords")
                  .once()
                  .then((DataSnapshot data) {
                print("data value = ${data.value}");
                print("data key = ${data.key}");
                setState(() {
                  var retrievedName1 = data.value;
                  retrievedName = retrievedName1['name'];
                  print("retreved name = $retrievedName");
                });
              });
            },
            child: Text("Get",style: TextStyle(fontSize: 20),),
          ),
          Text("$retrievedName",style: TextStyle(fontSize: 30)),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: textcontroller,
            ),
          ),
          Center(
              child: RaisedButton(
                  color: Colors.pinkAccent,
                  child: Text("Save to Database"),
                  onPressed: () {
                    databaseReference.child('onwords').update({'name': textcontroller.text});
                  }
              )
          ),

        ],
      ),
    );
  }
}