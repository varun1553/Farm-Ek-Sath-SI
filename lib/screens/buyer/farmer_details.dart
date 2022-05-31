import 'dart:async';

import 'package:farm_ek_sath/screens/buyer/get-farmer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FarmerDetails extends StatefulWidget {
  final String crop;
  // const FarmerDetails(this.cname);
  static const String id = 'farmer_details';
  const FarmerDetails({Key key, this.crop}) : super(key: key);

  @override
  _FarmerDetailsState createState() => _FarmerDetailsState(crop: this.crop);
}

class _FarmerDetailsState extends State<FarmerDetails> {
  String id = "", fname;
  Future futurefname;
  CollectionReference cr;
  String farmername = "", crop;

  _FarmerDetailsState({this.crop});

  Future<String> getFarmerName(String fid) async {
    var controller = StreamController();
    String farmer;

    var z = FirebaseFirestore.instance
        .collection("farmers")
        .where("f_id", isEqualTo: fid);
    z.snapshots().listen((event) {}).onData((data) {
      controller.sink.add(data.docs.map((e) => e.data()));
    });

    controller.stream.listen((event) {}).onData((data) {
      //print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
      for (var f in data) {
        print(f["f_name"]);
        farmer = f["f_name"];
      }
    });
    //print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    final duration = Duration(seconds: 10);
    return Future.delayed(duration).then((value) => farmer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Farmer Details"),
        ),
        body:Expanded(
          child:StreamBuilder(
            stream: FirebaseFirestore.instance.collection("crops").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView(
                  children: snapshot.data.docs.map<Widget>((document) {
                if (document["name"] == this.crop) {
                  this.id = document["f_id"];
                  return GetFarmer(id:this.id);
                } else {
                  return SizedBox.shrink();
                }
              }).toList());
            }) 
          ,)
         );
  }
}
