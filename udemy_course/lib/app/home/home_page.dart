import 'package:flutter/material.dart';
import 'package:udemy_course/app/home/account/account.dart';
import 'package:udemy_course/app/home/cupertino_home_scaffold.dart';
import 'package:udemy_course/app/home/jobs/jobs_page.dart';
import 'package:udemy_course/app/home/tab_items.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<TabItem,GlobalKey<NavigatorState>> navigatorKeys ={
    TabItem.jobs : GlobalKey<NavigatorState>(),
    TabItem.entries : GlobalKey<NavigatorState>(),
    TabItem.account : GlobalKey<NavigatorState>(),
  };
  TabItem _currentTab=TabItem.jobs;
  Map<TabItem,WidgetBuilder> get widgetbuilders{
    return {
      TabItem.jobs:(_)=>JobsPage(),
      TabItem.entries:(_)=>Container(),
      TabItem.account:(_)=>AccountPage(),
    };
  }
  void _select(TabItem tabItem) {
    if(tabItem==_currentTab){
      navigatorKeys[tabItem].currentState.popUntil((route)=>route.isFirst);
    }else {
      setState(() => _currentTab = tabItem);
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>!await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetbuilders: widgetbuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }


}
