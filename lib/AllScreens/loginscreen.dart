import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riderapp/AllScreens/mainscreen.dart';
import 'package:riderapp/AllScreens/registrationscreen.dart';
import 'package:riderapp/AllWidgets/progreeDialog.dart';
import 'package:riderapp/main.dart';

class LoginScreen extends StatelessWidget {

  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 25.0,),
              Image(
                image: AssetImage("images/logo.png"),
                width: 490.0,
                height: 350.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 1.0,),
              Text(
                "Login as a Raider",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 10.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 10.0,),
                    RaisedButton(
                      color: Colors.amberAccent,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "login",
                            style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0)
                      ),
                      onPressed: ()
                      {
                        if(!emailTextEditingController.text.contains("@"))
                        {
                          Fluttertoast.showToast(msg: "Email address not Valid",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,  );
                        }else if(passwordTextEditingController.text.isEmpty

                        )
                        {
                          Fluttertoast.showToast(msg: "Password is mandatory",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,  );
                        }else{
                          loginAndAuthenticatedUser(context);
                        }

                      },
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Do not have Account? Register Here",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
void  loginAndAuthenticatedUser(BuildContext context)async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)=> ProgressDialog(message: "Authenticating, Please wait..")

    );
    final User firebaseUser = (
        await _firebaseAuth.signInWithEmailAndPassword(
            email: emailTextEditingController.text, password: passwordTextEditingController.text
        ).catchError((errMsg){
         Navigator.pop(context);
        })).user;
    if(firebaseUser != null)// user created
        {

            userRef.child(firebaseUser.uid);
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);

          }else{
            Navigator.pop(context);
    }

    }
  }


