import 'package:endower/services/notification_services.dart';
import 'package:endower/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../bases/auth_base.dart';
import '../model/user_model.dart';

class FirebaseAuthServices implements AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  UserServices _userServices = UserServices();

  UserModel userFromFirebase(User user) {
    if (user != null) {
      return UserModel(id: user.uid, email: user.email, name: user.displayName, photo: user.photoURL);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      var _user = _firebaseAuth.currentUser;
      return userFromFirebase(_user);
    } catch (e) {
      print('An error has been occurred while trying to reach current user' + e.toString());
      return null;
    }
  }

  @override
  Future<UserModel> signIn() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> createUserWithEmail(String email, String password) async {
    try {
      var _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userFromFirebase(_userCredential.user);
    } catch (e) {
      print('An error has occurred while create with Email password ' + e.toString());
      return null;
    }
  }

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      var _userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userFromFirebase(_userCredential.user);
    } catch (e) {
      print('An error has occurred while signIn with Email password ' + e.toString());
      return null;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      var _googleUser = await _googleSignIn.signIn();
      if (_googleUser != null) {
        var _googleAuth = await _googleUser.authentication;
        if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
          var _response =
              await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken));
          await NotificationService.saveUserToken(_response.user.uid);
          return userFromFirebase(_response.user);
        }
        return null;
      }
      return null;
    } catch (e) {
      print('Google Sign In Error ' + e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      return true;
    } catch (e) {
      print('Error signOut' + e.toString());
      return false;
    }
  }
}
