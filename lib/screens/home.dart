import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import '../models/models.dart';

import '../screens/screens.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.currentTab,
  });

  final int currentTab;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    TestPageScreen(),
    GroceryScreen(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '食源性致病菌检测',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          profileButton(widget.currentTab),
        ],
      ),
      body: IndexedStack(index: widget.currentTab, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: widget.currentTab,
        onTap: (index) {
          Provider.of<AppStateManager>(context, listen: false).goToTab(index);
          context.goNamed(
            'home',
            params: {
              'tab': '$index',
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '检测',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '记录',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }

  Widget profileButton(int currentTab) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/img/author_ljl.jpeg',
          ),
        ),
        onTap: () {
          context.goNamed(
            'profile',
            params: {
              'tab': '$currentTab',
            },
          );
        },
      ),
    );
  }
}
