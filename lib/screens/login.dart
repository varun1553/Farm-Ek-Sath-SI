import 'package:farm_ek_sath/components/rounded_button.dart';
import 'package:farm_ek_sath/screens/buyer/buyer_screen.dart';
import 'package:farm_ek_sath/screens/famer/farmer_screen.dart';
import 'package:farm_ek_sath/screens/volunteer/volunteerScreen.dart';
import 'package:flutter/material.dart';
import 'package:farm_ek_sath/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum users { Farmer, Buyer, Volunteer }

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  users user = users.Farmer;

  @override
  Widget build(BuildContext context) {
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
                  // Flexible(
                  //   child: Hero(
                  //     tag: 'logo',
                  //     child: Container(
                  //       height: 200.0,

                  //     ),
                  //   ),
                  // ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://www.world-grain.com/ext/resources/Article-Images/2019/06-June/Corn_photo-cred-Adobestock_E.jpg?1559829447"),
                    radius: 80,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Login to Enter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 15.0,
                  ),

                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                  ),

                  SizedBox(
                    height: 8.0,
                  ),

                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Are you farmer or buyer or volunteer?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Radio(
                                value: users.Farmer,
                                groupValue: user,
                                onChanged: (users value) {
                                  setState(() {
                                    print("yessss");
                                    this.user = users.Farmer;
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
                                groupValue: user,
                                onChanged: (users value) {
                                  setState(() {
                                    print("yessss");
                                    this.user = users.Buyer;
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
                                groupValue: user,
                                onChanged: (users value) {
                                  setState(() {
                                    this.user = value;
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

                  SizedBox(
                    height: 14.0,
                  ),

                  RoundedButton(
                    title: 'Log In',
                    colour: Colors.lightBlueAccent,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => FarmerScreen()));

                          if (this.user == users.Farmer) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FarmerScreen()));

                          } else if (this.user == users.Buyer) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BuyerScreen()));
                          }
                          else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VolunteerScreen()));
                          }
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print("caught an error" + e.toString());
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
