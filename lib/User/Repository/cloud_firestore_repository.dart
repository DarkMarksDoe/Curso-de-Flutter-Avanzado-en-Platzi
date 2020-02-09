import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/User/Model/user.dart';
import 'package:platzi_trips_app/User/Repository/cloud_firestore_api.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) =>
      _cloudFirestoreAPI.updateUserData(user);
}
