import 'package:endower/dd/manager_page_navigations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/landing_viewmodel.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _landingviewmodel = Provider.of<LandingViewModel>(context, listen: false);
    //_landingviewmodel.loggedIn();
    if (_landingviewmodel.getLandingState == LandingState.NotLogged) {
      return Container(
        child: Center(child: Text('Not Logged In')),
      );
    } else {
      return Container(
        child: ManagerPageNavigation(),
      );
    }
  }
}
