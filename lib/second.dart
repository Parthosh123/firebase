import 'dart:convert';

import 'package:firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();
final messageRef = databaseReference.reference().child("${auth.currentUser.uid}");

class SecondPage extends StatefulWidget {


  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List data= [];
  String userName;
  String ipAddress;
String getData(){

  databaseReference.child(auth.currentUser.uid).once().then((DataSnapshot snapshot) {

    print('Data : ${snapshot.value}');

    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key,values) {
      print(values["name"]);
      setState(() {
        userName = values["name"];
        ipAddress = values["ip"];
      });

      return userName;
    });
  });
}

getDataFromOfflineIp()async {
  final response = await http.get(Uri.http("$ipAddress","/key"));

  var fetchdata = jsonDecode(response.body);
  print(fetchdata);
  if (response.statusCode == 200) {
    setState(() {
      data = fetchdata;
    });
    print("data is printing ---------- ");
    print("$data ");
  }
}


@override
  void initState() {
  getDataFromOfflineIp();
   getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  getDataFromOfflineIp();
  getData();
    return Scaffold(
      appBar: AppBar(
        title: Text("welcome page"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("user name = $userName"),
            SizedBox(
              height: 30.0,
            ),

            Text("Ip Adress = $ipAddress"),
            SizedBox(
              height: 30.0,
            ),
            Text("user devices = $data"),
            SizedBox(
              height: 30.0,
            ),
            FlatButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          nik()));
            }, child: Text("press")),

          ],
        ),

      ),
    );
  }
}
