import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AssignedPrice extends StatefulWidget {
  const AssignedPrice({ Key key }) : super(key: key);

  @override
  _AssignedPriceState createState() => _AssignedPriceState();
}

class _AssignedPriceState extends State<AssignedPrice> {
 FirebaseAuth _auth = FirebaseAuth.instance;
  User _firebaseUser;
  int c;

  @override
  Widget build(BuildContext context) {
    _firebaseUser = _auth.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Text("Assigned prices for your crop"),
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
                      document['name']+" : "+(document['price']),
                    ),
                  );
                }
                ).toList(),
              );
            }));
  }
}

