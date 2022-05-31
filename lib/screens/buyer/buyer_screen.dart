import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_ek_sath/screens/buyer/farmer_details.dart';
import 'package:flutter/material.dart';

class BuyerScreen extends StatefulWidget {
  static const String id = 'buyer_screen';

  @override
  _BuyerScreenState createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  List<String> crops = [];
  String crop = "";

  String getCrops(String cropName) {
    if (crops.contains(cropName)) {
      return "";
    }
    crops.add(cropName);
    return cropName;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("List of Crops Available currently"),
            ),
            body: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("crops").snapshots(),
                builder: (BuildContext context1,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("No crops available");
                  }
                  return ListView(
                      children: snapshot.data.docs.map((document) {
                    this.crop = document["name"];
                    if (crops.contains(this.crop)) {
                      return SizedBox.shrink();
                    } else {
                      crops.add(this.crop);
                      return ListTile(
                        title: Text(this.crop),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FarmerDetails(crop:this.crop)
                                    )
                                    ),
                      );
                    }
                  }).toList());
                })));
  }
}
