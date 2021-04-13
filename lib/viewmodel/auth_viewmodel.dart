import 'package:flutter/cupertino.dart';

import '../bases/auth_base.dart';
import '../model/user_model.dart';
import '../services/stats_services.dart';
import '../services/auth_services.dart';
import '../services/user_services.dart';

enum ViewState { Idle, Busy }

class AuthViewModel extends AuthBase with ChangeNotifier {
  FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();
  UserServices _userServices = UserServices();
  StatServices _analyticServices = StatServices();
  UserModel _user;
  ViewState _state;

  AuthViewModel() {
    _state = ViewState.Idle;
    currentUser();
  }

  UserModel get user => _user;
  void setState(ViewState value) {
    _state = value;
    notifyListeners();
  }

  ViewState get getState => _state;

  @override
  Future<UserModel> createUserWithEmail(String email, String password) async {
    try {
      setState(ViewState.Busy);
      var _responseUser = await _firebaseAuthServices.createUserWithEmail(email, password);
      _userServices.saveUser(_responseUser);
      _user = _responseUser;
      return _user;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      setState(ViewState.Busy);
      var _user1 = await _firebaseAuthServices.currentUser();
      _user = await _userServices.getUserById(_user1.id);
      return _user;
    } catch (e) {
      print('An error in userviewmodel currentuser' + e.toString());
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<UserModel> signIn() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      setState(ViewState.Busy);
      _user = await _firebaseAuthServices.signInWithEmail(email, password);
      return _user;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      setState(ViewState.Busy);
      var _recentuser = await _firebaseAuthServices.signInWithGoogle();
      await _analyticServices.createAnalytic(_recentuser.id);
      var _userfromfb = await _userServices.getUserById(_recentuser.id);
      if (_userfromfb == null) {
        _userServices.saveUser(_recentuser);
      }
      _user = _userfromfb;
      return _user;
    } catch (e) {
      print('error' + e.toString());
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  Future<bool> signOut() async {
    bool _response = false;
    try {
      setState(ViewState.Busy);
      _response = await (_firebaseAuthServices.signOut());
      _user = null;
      return _response;
    } catch (e) {
      print('An error in userviewmodel signout' + e.toString());
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }
}
