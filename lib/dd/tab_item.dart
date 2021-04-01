import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { Home, Search, Profile }

class TabItemData {
  final String label;
  final IconData icon;

  TabItemData(this.label, this.icon); //constructor

  static Map<TabItem, TabItemData> pages = {
    TabItem.Home: TabItemData('Home', Icons.home),
    TabItem.Search: TabItemData('Search', Icons.search),
    TabItem.Profile: TabItemData('Profile', Icons.person)
  };
}
