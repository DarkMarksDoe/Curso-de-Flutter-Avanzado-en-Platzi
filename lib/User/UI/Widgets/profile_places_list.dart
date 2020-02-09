import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/BLoC/bloc_user.dart';
import 'package:platzi_trips_app/User/UI/Widgets/profile_place.dart';
import 'package:platzi_trips_app/Place/Model/place.dart';

class ProfilePlacesList extends StatelessWidget {
  UserBloc userBloc;
  Place place = Place(
      name: 'Knuckles Mountains Range',
      description: 'Hiking. Water fall hunting. Natural bath',
      urlImage:
          'https://cdn.pixabay.com/photo/2019/06/24/11/33/mountain-4295794_960_720.jpg',
      likes: 3);
  Place place2 = Place(
      name: 'Knuckles Mountains Range',
      description: 'Hiking. Water fall hunting. Natural bath',
      urlImage:
          'https://cdn.pixabay.com/photo/2019/06/24/11/33/mountain-4295794_960_720.jpg',
      likes: 3);

  @override
  Widget build(BuildContext context) {
    userBloc=BlocProvider.of<UserBloc>(context);
    return Container(
      margin: EdgeInsets.only(
          top: 10.0,
          left: 20.0,
          right: 20.0,
          bottom: 10.0
      ),
      child: StreamBuilder(
          stream: userBloc.placesStream,
          builder: (context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                return Column(
                    children: userBloc.buildPlaces(snapshot.data.documents)
                );

              case ConnectionState.active:
                return Column(
                    children: userBloc.buildPlaces(snapshot.data.documents)
                );

              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
                return Column(
                    children: userBloc.buildPlaces(snapshot.data.documents)
                );

            }
          }

      ),
    );
  }
}
