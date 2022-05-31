import 'package:farm_ek_sath/screens/famer/listOfCrops.dart';
import 'package:flutter/material.dart';

class CurrentCropsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.greenAccent[100],
      child: Container(
        width: 150,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 50,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/7/8/3/5/2555387-1-eng-GB/Is-traditional-wheat-better-The-market-power-of-Russian-wheat-India-GM-crop-regulation-sustainable-rice-production.jpg"), //NetworkImage
                  radius: 48,
                ), //CircleAvatar
              ), //CirclAvatar
              Container(
                height: 15,
              ), //SizedBox
              Text(
                'Your Current Crops',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ), //Textstyle
              ), //Text
              Container(
                height: 20,
              ), //SizedBox

              // Container(
              //   height: 10,
              // ), //SizedBox
              Container(
                width: 100,
                height: 30,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>ListOfCrops())
                    ),

                  //child: Padding(
                  //padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Icon(Icons.remove_red_eye_rounded),
                      Text(' View',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ],
                  ), //Row
                  //), //Padding
                ), //RaisedButton
              ) //SizedBox
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}