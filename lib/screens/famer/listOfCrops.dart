import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfCrops extends StatefulWidget {
  @override
  _ListOfCropsState createState() => _ListOfCropsState();
}

class _ListOfCropsState extends State<ListOfCrops> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _firebaseUser;
  int c;

  @override
  Widget build(BuildContext context) {
    _firebaseUser = _auth.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Text("List Of Crops"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('crops').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("Please add crops");
              }
              return ListView(
                children: snapshot.data.docs.map((document) {
                  if (_firebaseUser.uid != document['f_id']) {
                    return SizedBox.shrink();
                  }
                  return ListTile(
                    title: Text(
                      document['name'],
                    ),
                  );
                }
                ).toList(),
              );
            }));
  }
}
