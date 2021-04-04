import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../dd/tab_item.dart';

class ManagerPageViewModel with ChangeNotifier {
  TabItem _currentTab;
  TabItem _onSelectedTab;

  void setCurrentTab(TabItem tabItem) => _currentTab = tabItem;
  TabItem get currentTab => _currentTab;
  void setSelectedTab(TabItem tabItem) => _onSelectedTab = tabItem;
  TabItem get selectedTab => _onSelectedTab;

  Map<TabItem, Widget> _createPage;
  void setCreatePage(Map<TabItem, Widget> a) => _createPage = a;
  get getcreatePage => _createPage;
}
