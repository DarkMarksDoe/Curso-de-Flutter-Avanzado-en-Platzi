import 'package:flutter/material.dart';
import 'package:platzi_trips_app/User/UI/Screens/profile_header.dart';
import 'package:platzi_trips_app/User/UI/Widgets/profile_places_list.dart';
import 'package:platzi_trips_app/User/UI/Widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*return Container(
      color: Colors.indigo,
    );*/
    return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader(),
            ProfilePlacesList()
          ],
        ),
      ],
    );
  }

}