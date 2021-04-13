import 'package:endower/bottom_navigation/manager_page_navigations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/auth_viewmodel.dart';
import '../authentication/login_view.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthViewModel _authViewModel = Provider.of<AuthViewModel>(context);
    if (_authViewModel.getState == ViewState.Idle) {
      if (_authViewModel.user != null) {
        return ManagerPageNavigation();
      } else {
        return LoginView();
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
