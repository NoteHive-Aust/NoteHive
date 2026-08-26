import 'package:flutter/material.dart';
import 'package:notehive/Screens/browseRoom.dart';
import 'package:notehive/Screens/homeScreen.dart';
import 'package:notehive/Screens/profile_screen.dart';
import 'package:notehive/Screens/setting_screen.dart';

import '../widgets/bottomNavigation.dart';

class Pagecontroller extends StatefulWidget {
  const Pagecontroller({super.key});

  @override
  State<Pagecontroller> createState() => _PagecontrollerState();
}

class _PagecontrollerState extends State<Pagecontroller>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,

            children: [
              Homescreen(),
              Browseroom(),
              ProfileScreen(),
              SettingScreen(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomNavigation(
              selectedIndex: _tabController.index,
              onItemSelected: (index) {
                setState(() {
                  _tabController.animateTo(index);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
