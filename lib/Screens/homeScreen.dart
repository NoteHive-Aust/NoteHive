import 'package:flutter/material.dart';

import '../widgets/bottomNavigation.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: Text('Hello Niggas'),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: bottomNavigation()),
        ],
      ),
    );
  }
}
