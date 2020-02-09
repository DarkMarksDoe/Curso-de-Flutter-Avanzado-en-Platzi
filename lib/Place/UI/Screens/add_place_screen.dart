import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/Model/place.dart';
import 'package:platzi_trips_app/Place/UI/Widgets/card_image.dart';
import 'package:platzi_trips_app/Place/UI/Widgets/text_input_location.dart';
import 'package:platzi_trips_app/User/BLoC/bloc_user.dart';
import 'package:platzi_trips_app/Widgets/button_purple.dart';
import 'package:platzi_trips_app/Widgets/gradient_back.dart';
import 'package:platzi_trips_app/Widgets/text_input.dart';
import 'package:platzi_trips_app/Widgets/title_header.dart';

class AddPlaceScreen extends StatefulWidget {
  File image;

  AddPlaceScreen({Key key, this.image});

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    final _controllerTitlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(
            height: 300.0,
          ),
          Row(
            //App Bar
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 5.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 45,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              Flexible(
                  child: Container(
                padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                child: TitleHeader(title: "Add a new Place"),
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
            child: ListView(children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.center,
                child: CardImageWithFabIcon(
                  pathImage: widget.image.path,
                  width: 350.0,
                  left: 0.0,
                  onPressedFabIcon: () {},
                  iconData: Icons.camera,
                  height: 250.0,
                ),
              ), //Foto
              Container(
                //TextField Title
                margin: EdgeInsets.only(bottom: 20.0),
                child: TextInput(
                  hintText: "Title",
                  inputType: null,
                  maxLines: 1,
                  controller: _controllerTitlePlace,
                ),
              ),
              Container(
                //TextField Title
                margin: EdgeInsets.only(bottom: 20.0),
                child: TextInput(
                  hintText: "Description",
                  inputType: TextInputType.multiline,
                  maxLines: 4,
                  controller: _controllerDescriptionPlace,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: TextInputLocation(
                    iconData: Icons.location_on,
                    controller: null,
                    hintText: "Add location",
                  )),
              Container(
                width: 70.0,
                child: ButtonPurple(
                    buttonText: "Add place",
                    onPressed: () {
                      //ID DEL USUARIO LOGEADO ACTUALMENTE
                      userBloc.currentUser.then((FirebaseUser user) {
                        if (user != null) {
                          String uid = user.uid;
                          String path =
                              "${uid}/${DateTime.now().toString()}.jpg"; //hacer archivo unico
                          //1.- FirebaseStorage
                          //URL
                          userBloc
                              .uploadFile(path, widget.image)
                              .then((StorageUploadTask storageUploadTask) {
                            storageUploadTask.onComplete
                                .then((StorageTaskSnapshot snapshot) {
                              snapshot.ref.getDownloadURL().then((urlImage) {
                                print("URL IMAGEN SUBIDA: ${urlImage}");
                                //2. Cloud Firestore
                                //Place - title, description, url, userOwner, likes
                                userBloc.updatePlaceData(Place(
                                  name: _controllerTitlePlace.text,
                                  description: _controllerDescriptionPlace.text,
                                  urlImage: urlImage,
                                  likes: 0,

                                )).whenComplete(() {
                                  print("TERMINO");
                                  Navigator.pop(context);
                                });
                              });
                            });
                          });
                        }
                      });
                      //Firebase Storage
                      //URL
                      //Cloud Firestore
                      //Place - Title, description, url, userOwner, likes
                    }),
              )
            ]),
          )
        ],
      ),
    );
  }
}
