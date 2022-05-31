import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_ek_sath/screens/buyer/buyer_screen.dart';
import 'package:farm_ek_sath/screens/famer/farmer_screen.dart';
import 'package:farm_ek_sath/screens/volunteer/volunteerScreen.dart';
import 'package:flutter/material.dart';
import 'package:farm_ek_sath/components/rounded_button.dart';
import 'package:farm_ek_sath/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}


enum users { Farmer, Buyer, Volunteer,FFV }

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  User _firebaseUser;
  bool showSpinner = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController user = TextEditingController();
  users user1 = users.Farmer;
  

  @override
  Widget build(BuildContext context) {
    _firebaseUser=_auth.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://www.world-grain.com/ext/resources/Article-Images/2019/06-June/Corn_photo-cred-Adobestock_E.jpg?1559829447"),
                    radius: 80,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Get Registered',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  // TextField(
                  //   controller: user,
                  //   obscureText: true,
                  //   textAlign: TextAlign.center,
                  //   decoration: kTextFieldDecoration.copyWith(
                  //       hintText: 'Buyer?Farmer?Volunteer?'),
                  // ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Radio(
                                value: users.Farmer,
                                groupValue: user1,
                                onChanged: (users value) {
                                  setState(() {
                                    this.user1 = users.Farmer;
                                  });
                                },
                              ),
                              const Text('Farmer'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Radio(
                                value: users.Buyer,
                                groupValue: user1,
                                onChanged: (users value) {
                                  setState(() {
                                    this.user1 = users.Buyer;
                                  });
                                },
                              ),
                              Text('Buyer'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Radio(
                                value: users.Volunteer,
                                groupValue: user1,
                                onChanged: (users value) {
                                  setState(() {
                                    this.user1 = users.Volunteer;
                                  });
                                },
                              ),
                              Text('Volunteer'),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                  Row(
                    children : [Expanded(
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Radio(
                                value: users.FFV,
                                groupValue: user1,
                                onChanged: (users value) {
                                  setState(() {
                                    this.user1 = users.FFV;
                                  });
                                },
                              ),
                              Text('Farmer from volunteer'),
                            ],
                          ),
                        ),
                      ),],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: username,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your user name'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: password,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'Register',
                    colour: Colors.blueAccent,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email.text, password: password.text);

                        if (this.user1 == users.Farmer) {
                          Map<String, dynamic> newUserMap = {
                            "f_name": username.text,
                            "f_id": newUser.user.uid,
                            "v_id":null
                          };
                          CollectionReference collectionReference =
                              FirebaseFirestore.instance.collection('farmers');
                          collectionReference.add(newUserMap);
                          if (newUser != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FarmerScreen()));
                          }
                        } else if (this.user1 == users.Buyer) {
                          Map<String, dynamic> newUserMap = {
                            "b_name": username.text,
                            "b_id": newUser.user.uid
                          };
                          CollectionReference collectionReference1 =
                              FirebaseFirestore.instance.collection('buyer');
                          collectionReference1.add(newUserMap);
                          if (newUser != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BuyerScreen()));
                          }
                        } else if(this.user1 == users.Volunteer){
                          Map<String, dynamic> newUserMap = {
                            "v_name": username.text,
                            "v_id": newUser.user.uid
                          };
                          CollectionReference collectionReference1 =
                              FirebaseFirestore.instance
                                  .collection('volunteer');
                          collectionReference1.add(newUserMap);
                          if(newUser!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerScreen()));
                          }
                        }
                        else{
                            Map<String, dynamic> newUserMap = {
                            "f_name": username.text,
                            "f_id": newUser.user.uid,
                            "v_id":_firebaseUser.uid
                          };
                          CollectionReference collectionReference1 =
                              FirebaseFirestore.instance
                                  .collection('farmers');
                          collectionReference1.add(newUserMap);
                          if(newUser!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerScreen()));
                          }
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 90.0, right: 90.0),
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => FarmerScreen()));
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
