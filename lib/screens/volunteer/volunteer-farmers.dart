import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VOlunteerFarmers extends StatefulWidget {
  const VOlunteerFarmers({Key key}) : super(key: key);

  @override
  _VOlunteerFarmersState createState() => _VOlunteerFarmersState();
}

class _VOlunteerFarmersState extends State<VOlunteerFarmers> {
  final _auth = FirebaseAuth.instance;
  User _firebaseUser;
  @override
  Widget build(BuildContext context) {
    _firebaseUser = _auth.currentUser;
    return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('farmers').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("Please add farmers");
              }
              return ListView(
                children: snapshot.data.docs.map((document) {
                  if (_firebaseUser.uid != document['v_id']) {
                    return SizedBox.shrink();
                  }
                  return ListTile(
                    title: Text(
                      document['f_name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  );
                }).toList(),
              );
            });
  }
}
