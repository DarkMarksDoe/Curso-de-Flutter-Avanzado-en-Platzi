import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/Place/Model/place.dart';
import 'package:platzi_trips_app/User/Model/user.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";
  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, merge: true); //Sería como un commit
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    await _auth.currentUser().then((FirebaseUser user) {
      refPlaces.add({
        'name': place.name,
        'description': place.description,
        'likes': place.likes,
        'urlImage': place.urlImage,
        'userOwner':
            _db.document("${USERS}/${user.uid}") //así asigno a referencias
      }).then((DocumentReference dr) {
        dr.get().then((DocumentSnapshot snapshot) {
          //ID PLACE que acabo de asignar REFERECIA COMO ARRAY
          DocumentReference refUsers = _db
              .collection(USERS)
              .document(user.uid); //Obtener data del usuario que su id es tal
          refUsers.updateData({
            'myPlaces': FieldValue.arrayUnion(
                [_db.document("${PLACES}/${snapshot.documentID}")])
          });
        });
      });
    });
  }
}
