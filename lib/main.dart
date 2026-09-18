import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notehive/Screens/startingScreen.dart';
import 'package:notehive/Screens/pageController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
  runApp(MyApp(isloggedIn: isLoggedIn,));
}

class MyApp extends StatelessWidget {
  final bool isloggedIn;
  const MyApp({super.key,required this.isloggedIn});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteHive',
      theme: ThemeData(
        fontFamily: 'heading',
        splashColor: Color(0xFFE6E3FC).withOpacity(0.7),
        colorScheme: .fromSeed(seedColor: Color(0xff8474F0)),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Heading',
            color: Color(0xff1A1730),
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(overlayColor: Color(0xff8474F0)),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            overlayColor: Color(0xff8474F0),
            side: BorderSide(color: Color(0xFF352E60).withOpacity(0.1)),
          visualDensity: VisualDensity.compact,
          ),
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Color(0xFF352E60).withOpacity(0.1)),
          ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xff1A1730),
            fontFamily: 'heading',
          ),
          subtitleTextStyle: TextStyle(
            height: 2,
            fontFamily: 'paragraph',
            fontSize: 14,
            color: Color(0xff352E60).withOpacity(0.6),
          ),
          visualDensity: VisualDensity.compact,
          //splashColor: Color(0xFFE6E3FC).withOpacity(0.7),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
      home: isloggedIn? Pagecontroller(): StartingScreen(),
    );
  }
}
