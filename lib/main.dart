import 'package:endower/home_view.dart';
import 'package:endower/profile_view.dart';
import 'package:endower/search_view.dart';
import 'package:endower/viewmodel/manager_page_navi_viewmodel.dart';
import 'package:endower/viewmodel/search_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dd/bottom_navigation_bar.dart';
import 'landing_view.dart';
import 'viewmodel/home_viewmodel.dart';
import 'viewmodel/landing_viewmodel.dart';
import 'viewmodel/profile_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ManagerPageViewModel()),
      ChangeNotifierProvider(create: (context) => LandingViewModel()),
      ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ChangeNotifierProvider(create: (context) => ProfileViewModel()),
      ChangeNotifierProvider(create: (context) => SearchViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LandingView(),
      /*initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => LandingView(),
        '/Home': (context) => HomeView(),
        'Search': (context) => SearchView(),
        '/Profile': (context) => ProfileView(),
      },*/
    );
  }
}
