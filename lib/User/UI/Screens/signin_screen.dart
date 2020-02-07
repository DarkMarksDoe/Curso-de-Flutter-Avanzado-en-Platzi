import 'package:flutter/material.dart';
import 'package:platzi_trips_app/User/BLoC/bloc_user.dart';
import 'package:platzi_trips_app/Widgets/button_green.dart';
import 'package:platzi_trips_app/Widgets/gradient_back.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return signInGoogleUi();
  }
  Widget signInGoogleUi(){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack("",null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome\n This is a travel app :3",
                style: TextStyle(
                    fontSize: 37.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Lato"),
              ),
              ButtonGreen(text: "Login with Gmail",
                onPressed: (){
                userBloc.signIn();
              }
              ,width: 300,
                height: 50,
              )
            ]
          )
        ]
      )
    );
  }

}
