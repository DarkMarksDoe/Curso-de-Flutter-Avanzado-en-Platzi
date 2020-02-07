import 'dart:async';

import'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/User/Repository/firebase_auth_api.dart';


class AuthRepository{
  final _firebaseAuthAPI = FirebaseAuthAPI();
  Future<FirebaseUser> signInFirebase() => _firebaseAuthAPI.signIn();
}
