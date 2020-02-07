import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/Repository/auth_repository.dart';

class UserBloc extends Bloc{
  final _auth_repository = AuthRepository();

  //Casos uso
  //1. SignIn a la aplicación Google
  Future<FirebaseUser> signIn() {
    return _auth_repository.signInFirebase();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}