import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_ek_sath/screens/famer/farmer_screen.dart';
import 'package:farm_ek_sath/screens/login.dart';
import 'package:farm_ek_sath/screens/registration.dart';

import 'package:farm_ek_sath/screens/volunteer/volunteer-farmers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VolunteerScreen extends StatefulWidget {
  const VolunteerScreen({Key key}) : super(key: key);

  @override
  VolunteerScreenState createState() => VolunteerScreenState();
}

class VolunteerScreenState extends State<VolunteerScreen> {
  final _auth = FirebaseAuth.instance;
  User _firebaseUser;
  @override
  Widget build(BuildContext context) {
    _firebaseUser = _auth.currentUser;
    return Scaffold(
        appBar: AppBar(title: Text("Farmers you are dealing")),
        body:Column(
          children: [
            Expanded(child: 
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('farmers')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        ),
                        onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginScreen())) ,
                      );
                    }).toList(),
                  );
                }),
            ),
        
        
        SizedBox(
            height: 40,
          ),
        
           ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  
                      return Colors.green; 
                    },
                  ),
                
                ),
                child: const Text('ADD Farmer'),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()));
                }),
        
          ],
        ) 
        
        
        
        );
  }
}
