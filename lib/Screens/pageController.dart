import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:notehive/Screens/browseRoom.dart';
import 'package:notehive/Screens/homeScreen.dart';
import 'package:notehive/Screens/profile_screen.dart';
import 'package:notehive/Screens/setting_screen.dart';

import '../Structures/userStructure.dart' show User;
import '../widgets/bottomNavigation.dart';

class Pagecontroller extends StatefulWidget {
  const Pagecontroller({super.key});

  @override
  State<Pagecontroller> createState() => _PagecontrollerState();
}

class _PagecontrollerState extends State<Pagecontroller>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  User? user;
  Future<void> getUser() async {
    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(uid)
        .get();
    setState(() {
      user = User.fromMap(userData.data()!);
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (user == null)
            Center(child: CircularProgressIndicator())
          else
            TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,

              children: [
                Homescreen(user: user),
                Browseroom(user: user),
                ProfileScreen(),
                SettingScreen(user: user),],
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomNavigation(
              context: context,
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
