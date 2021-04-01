import 'package:flutter/material.dart';

enum LandingState { Logged, NotLogged }

class LandingViewModel with ChangeNotifier {
  LandingState _landingState = LandingState.Logged;

  setLandingState(LandingState state) {
    _landingState = state;
    notifyListeners();
  }

  void loggedIn() {
    setLandingState(LandingState.Logged);
  }

  get getLandingState => _landingState;
}
