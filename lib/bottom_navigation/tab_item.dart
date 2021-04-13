import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { Home, Search, Notification }

class TabItemData {
  final String label;
  final IconData icon;

  TabItemData(this.label, this.icon); //constructor

  static Map<TabItem, TabItemData> pages = {
    TabItem.Home: TabItemData('Home', Icons.home),
    TabItem.Search: TabItemData('Search', Icons.search),
    TabItem.Notification: TabItemData('Notification', Icons.notifications)
  };
}
