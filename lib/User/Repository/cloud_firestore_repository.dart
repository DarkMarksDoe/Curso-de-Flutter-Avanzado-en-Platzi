import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/Place/Model/place.dart';
import 'package:platzi_trips_app/User/Model/user.dart';
import 'package:platzi_trips_app/User/UI/Widgets/profile_place.dart';

import 'cloud_firestore_api.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI  = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreAPI.updatePlaceData(place);
  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placeListSnapshot) => _cloudFirestoreAPI.buildPlaces(placeListSnapshot);

}