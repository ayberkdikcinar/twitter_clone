import 'package:flutter/material.dart';

import '../view/home_view.dart';
import '../view/profile_view.dart';
import '../view/search_view.dart';
import 'bottom_navigation_bar.dart';
import 'tab_item.dart';

class ManagerPageNavigation extends StatefulWidget {
  ManagerPageNavigation({Key key}) : super(key: key);

  @override
  _ManagerPageNavigationState createState() => _ManagerPageNavigationState();
}

class _ManagerPageNavigationState extends State<ManagerPageNavigation> {
  // ignore: prefer_final_fields

  Map<TabItem, Widget> get allPages => {
        TabItem.Home: HomeView(),
        TabItem.Search: SearchView(),
        TabItem.Profile: ProfileView(),
      };

  @override
  Widget build(BuildContext context) {
    return BottomNavigation(
      createPage: allPages,
    );
  }
}
