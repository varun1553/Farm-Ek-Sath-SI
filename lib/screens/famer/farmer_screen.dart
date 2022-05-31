import 'package:farm_ek_sath/screens/famer/add-crops-card.dart';
import 'package:farm_ek_sath/screens/famer/crop-price-card.dart';
import 'package:farm_ek_sath/screens/famer/currentCropsCard.dart';
import 'package:farm_ek_sath/screens/login.dart';
import 'package:flutter/material.dart';

class FarmerScreen extends StatefulWidget {
  static const String id = 'farmer_screen';

  @override
  _FarmerScreenState createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Farm Ek Sath"),
        ),
        body: Column(children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 250.0),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text('Logout')),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(children: [
            SizedBox(
              width: 20,
            ),
            CurrentCropsCard(), //Card,
            AddCropsCard(), //Card,
          ]),
          CropPriceCard(),
        ]),
      ),
    );
  }
}
