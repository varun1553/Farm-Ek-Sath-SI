import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetFarmer extends StatelessWidget {
  final String id;
  const GetFarmer({
    Key key,this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("farmers").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView(
              children: snapshot.data.docs.map<Widget>((document) {
            if (document["f_id"] == this.id) {
              return Text(document["f_name"]);
            } else {
              return Text("none");
            }
          }).toList());
        });
  }
}
