import 'package:farm_ek_sath/screens/famer/addScreen.dart';
import 'package:flutter/material.dart';

class AddCropsCard extends StatelessWidget {
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
                      "https://th.bing.com/th/id/OIP.4gGvCz6m2lCsdXbqOx09EQHaEK?w=313&h=180&c=7&o=5&dpr=1.25&pid=1.7"), //NetworkImage
                  radius: 48,
                ), //CircleAvatar
              ), //CirclAvatar
              Container(
                height: 15,
              ), //SizedBox
              Text(
                'Add new crops',
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
                  onPressed:  () {
                                    Navigator.push(
                                    context,
                                      MaterialPageRoute(builder: (context) => AddScreen()),
                                    );
                                  },

                  //child: Padding(
                  //padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text('Add',
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