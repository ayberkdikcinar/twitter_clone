import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bases/view_statefull_base.dart';
import '../core/components/custom_textFormField_widget.dart';
import '../core/components/custom_text_button_widget.dart';
import '../viewmodel/auth_viewmodel.dart';

class ProfileSettingView extends StatefulWidget {
  ProfileSettingView({Key key}) : super(key: key);

  @override
  _ProfileSettingViewState createState() => _ProfileSettingViewState();
}

class _ProfileSettingViewState extends StatefullBase<ProfileSettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextButton(
              backgroundColor: Theme.of(context).cardColor,
              onPressed: () {},
              text: 'Save',
            ),
          )
        ],
      ),
      body: Form(
          child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(Provider.of<AuthViewModel>(context).user.photo),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: dynamicHeight(0.05),
                width: dynamicWidth(0.5),
                child: CustomTextFormField(
                  borderRadious: 0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: dynamicHeight(0.05),
                width: dynamicWidth(0.5),
                child: CustomTextFormField(
                  borderRadious: 0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //height: dynamicHeight(0.05),
                width: dynamicWidth(0.5),
                child: CustomTextFormField(
                  borderRadious: 0,
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
