import 'package:flutter/cupertino.dart';
import 'package:notehive/Screens/homeScreen.dart';
import 'package:notehive/Screens/startingScreen.dart';

import 'auth_services.dart';



class AuthLayout extends StatelessWidget{
  final Widget? pageIfConnected;
  const AuthLayout({super.key, 
  this.pageIfConnected});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: authServices, builder:(context, AuthServices, child) {
      return StreamBuilder(
        stream: AuthServices.authStateChanges,
        builder: (context, snapshot) {
          Widget widget;
          if(snapshot.connectionState == ConnectionState.waiting){
            widget=  Center(child: CupertinoActivityIndicator(),);
          }
          else if(snapshot.hasData){
            widget= Homescreen();
          }
          else{
            widget = pageIfConnected ?? StartingScreen();
          }
          return widget;
        },
      );
    });
  }
}