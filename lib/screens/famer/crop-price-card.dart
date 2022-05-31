import 'package:farm_ek_sath/screens/famer/assigned-prices.dart';
import 'package:flutter/material.dart';

class CropPriceCard extends StatelessWidget {
  

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
                        "https://9to5mac.com/wp-content/uploads/sites/6/2019/08/most-cash-rich-company.jpg?quality=82&strip=all"), //NetworkImage
                    radius: 48,
                  ), //CircleAvatar
                ), //CirclAvatar
                Container(
                  height: 15,
                ), //SizedBox
                Text(
                  'Crop Price',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ), //Textstyle
                ), //Text
                Container(
                  height: 10,
                ), //SizedBox

                Container(
                  height: 10,
                ), //SizedBox
                Container(
                  width: 100,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                                    Navigator.push(
                                    context,
                                      MaterialPageRoute(builder: (context) => AssignedPrice()),
                                    );
                                  },

                    //child: Padding(
                    //padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        //Icon(Icons.remove_red_eye_rounded),
                        Text('View price',
                            style: TextStyle(
                              fontSize: 13,
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