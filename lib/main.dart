import 'package:farm_ek_sath/screens/famer/farmer_screen.dart';
import 'package:farm_ek_sath/screens/login.dart';
import 'package:farm_ek_sath/screens/registration.dart';
import 'package:farm_ek_sath/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FarmEkSath());
}

class FarmEkSath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        FarmerScreen.id: (context) => FarmerScreen(),
      },
    );
  }
}
