import 'package:flutter/material.dart';
import 'package:udemy_course/app/home/cupertino_home_scaffold.dart';
import 'package:udemy_course/app/home/tab_items.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentItem=TabItem.jobs;
  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentItem,
      onSelectTab: (items){},
    );
  }
}
