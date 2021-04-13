import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/dark_theme.dart';
import 'services/notification_services.dart';
import 'view/landing_view.dart';
import 'viewmodel/auth_viewmodel.dart';
import 'home/home_viewmodel.dart';
import 'bottom_navigation/manager_page_navi_viewmodel.dart';
import 'profile/viewmodel/profile_setting_viewmodel.dart';
import 'profile/viewmodel/profile_viewmodel.dart';
import 'viewmodel/search_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ManagerPageViewModel()),
      ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ChangeNotifierProvider(create: (context) => ProfileViewModel()),
      ChangeNotifierProvider(create: (context) => SearchViewModel()),
      ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ChangeNotifierProvider(create: (context) => ProfileSettingsViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LandingView(),
      theme: DarkTheme.instance.data,
    );
  }
}
