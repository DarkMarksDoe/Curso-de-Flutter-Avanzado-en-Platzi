import 'package:platzi_trips_app/Place/Model/place.dart';
import 'package:platzi_trips_app/User/Model/user.dart';

import 'cloud_firestore_api.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI  = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreAPI.updatePlaceData(place);
}