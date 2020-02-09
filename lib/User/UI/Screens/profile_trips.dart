import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/BLoC/bloc_user.dart';
import 'package:platzi_trips_app/User/Model/user.dart';
import 'package:platzi_trips_app/User/UI/Screens/profile_header.dart';
import 'package:platzi_trips_app/User/UI/Widgets/profile_places_list.dart';
import 'package:platzi_trips_app/User/UI/Widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    // TODO: implement build
    /*return Container(
      color: Colors.indigo,
    );*/
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return CircularProgressIndicator();
            break;
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          case ConnectionState.active:
            return showProfileData(snapshot);
            break;
          case ConnectionState.done:
            return showProfileData(snapshot);
            break;
          default:
            return showProfileData(snapshot);
        }
      },
    );
      /*
      Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader(), //User Datos
            ProfilePlacesList()//User ID
          ],
        ),
      ],
    );
       */
  }
  Widget showProfileData(AsyncSnapshot snapshot){
    if(!snapshot.hasData || snapshot.hasError){
      print("NO ESTA LOGEADO");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              Text("USUARIO NO LOGEADO, HAZ LOGIN")//User ID
            ],
          ),
        ],
      );
    }else{
      print("LOGEADO mamalon");
      var user = User(
          photoURL: snapshot.data.photoUrl,
          uid: snapshot.data.uid,
          email: snapshot.data.email,
          name: snapshot.data.displayName);
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              ProfileHeader(user: user), //User Datos
              ProfilePlacesList(user: user)//User ID
            ],
          ),
        ],
      );
    }
  }
}
