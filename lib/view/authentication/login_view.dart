import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/components/custom_text_button_widget.dart';
import '../../core/localization/strings.dart';
import '../../viewmodel/auth_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextButton(
              text: ApplicationStrings.instance.loginwithGoogle,
              backgroundColor: Theme.of(context).splashColor,
              onPressed: () async => await loginWithGoogle(context),
            ),
            CustomTextButton(
              text: ApplicationStrings.instance.loginWithEmail,
              backgroundColor: Theme.of(context).splashColor,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  loginWithGoogle(BuildContext context) async {
    final _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    await _authViewModel.signInWithGoogle();
  }
}
