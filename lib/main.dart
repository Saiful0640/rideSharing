import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderapp/AllScreens/loginscreen.dart';
import 'package:riderapp/AllScreens/mainscreen.dart';
import 'package:riderapp/AllScreens/registrationscreen.dart';
import 'package:riderapp/DataHandler/appData.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
          title: 'Taxi Raider App',
          theme: ThemeData(
            fontFamily: "Brand Bold",
            primarySwatch: Colors.blue,
          ),
          initialRoute: MainScreen.idScreen,
          routes: {
            RegistrationScreen.idScreen:(context) => RegistrationScreen(),
            LoginScreen.idScreen:(context) => LoginScreen(),
            MainScreen.idScreen: (context) => MainScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
    );
    ;
  }
}

