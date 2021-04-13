import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manager_page_navi_viewmodel.dart';
import 'tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key key, this.createPage}) : super(key: key);
  final Map<TabItem, Widget> createPage;
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _tabItem(TabItem.Home),
          _tabItem(TabItem.Search),
          _tabItem(TabItem.Notification),
        ],
        onTap: (value) => Provider.of<ManagerPageViewModel>(context, listen: false).setSelectedTab(TabItem.values[value]),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => createPage[TabItem.values[index]],
        );
      },
    );
  }

  BottomNavigationBarItem _tabItem(TabItem _item) {
    var _response = TabItemData.pages[_item];
    return BottomNavigationBarItem(icon: Icon(_response.icon), label: _response.label);
  }
}
