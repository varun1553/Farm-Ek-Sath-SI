import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_ek_sath/screens/famer/farmer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/material/scaffold.dart';
import 'package:alert/alert.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'ADD CROP SCREEN';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCropForm(),
      ),
    );
  }
}

class MyCropForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCropForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cropPrice = TextEditingController();
  TextEditingController cropName = TextEditingController();
  TextEditingController maxQuantity = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _firebaseUser;

  addcrop() {
    _firebaseUser = _auth.currentUser;
    Map<String, dynamic> newData = {
      "name": cropName.text,
      "price": cropPrice.text,
      "maximum_quantity": maxQuantity.text,
      "f_id": _firebaseUser.uid
    };

    CollectionReference collectionreference =
        FirebaseFirestore.instance.collection('crops');
    collectionreference.add(newData);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FarmerScreen()));
    Alert(message: 'Added Successfully', shortDuration: true).show();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               TextFormField(
              controller: cropName,
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'paddy',
                labelText: 'Enter crop name',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some data';
                }
                return null;
              },
              
            ),
              TextFormField(
                controller: cropPrice,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.money),
                  hintText: '200/kg',
                  labelText: 'Minimum Cost per kg or quintal',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some data';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.photo_album),
                  hintText: 'Add the photos related to product',
                  labelText: 'Photos',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some data';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: maxQuantity,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.money),
                  hintText: 'Maximum quantity you can provide in kgs or quintal',
                  labelText: 'Maximum quantity',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some data';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 110.0, top: 40.0, right: 20.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.grey; // Use the component's default.
                          },
                        ),
                      ),
                      child: const Text('Back'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FarmerScreen()));
                      },
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              // if (states.contains(MaterialState.pressed))
                              //   return Colors.red;
                              return Colors
                                  .green; // Use the component's default.
                            },
                          ),
                        ),
                        child: const Text('ADD+'),
                        onPressed: addcrop,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
