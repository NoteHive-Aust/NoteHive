import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notehive/Screens/edit_profile.dart';
import 'package:notehive/Screens/login.dart';
import 'package:notehive/Screens/notifications_screen.dart';
import 'package:notehive/Screens/signup.dart';
import 'package:notehive/Screens/startingScreen.dart';
import 'package:notehive/Structures/userStructure.dart' show User;

import '../widgets/AppbarWidgets.dart';
import '../widgets/bottomNavigation.dart';
import '../widgets/searchBox.dart';

class SettingScreen extends StatefulWidget {
  final User? user;
  SettingScreen({super.key,required this.user});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool pushNotification = false;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(fontFamily: 'Heading', fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [
          NotificationButtonForAppBar(
            context: context,
            screen: NotificationsScreen(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                SizedBox(height: 20),
               // SearchBox(lebel: "Search for Settings", controller: TextEditingController(), onChanged: () {},),
                //SizedBox(height: 20,),
                ProfileEditTab(),
                SizedBox(height: 20),
                PushNotificationToggle(),
                SizedBox(height: 20),
                Text("Account", style: TextStyle(color: Color(0xff352E60))),
                AccountSettingsTab(),
                SizedBox(height: 20),
                Text("Appearance", style: TextStyle(color: Color(0xff352E60))),
                ApearanceSettingsTab(),
                //SizedBox(height: 20,),
                SignoutDeleteTab(),
                Emnei(),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container Emnei() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF352E60).withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Tiles(
            method: () {},
            icon: Icons.question_mark_outlined,
            title: "Help & FAQ",
            tail: '',
          ),
          Divider(),
          Tiles(
            method: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  height: 200,
                  child: Center(child: Text("App Version: 1.0.0")),
                ),
              );
            },
            icon: Icons.phone_android_rounded,
            title: "App Version",
            tail: '',
          ),
          Divider(),
          Tiles(
            method: () {},
            icon: Icons.insert_drive_file_outlined,
            title: "Terms & Condition",
            tail: '',
          ),
        ],
      ),
    );
  }

  Container SignoutDeleteTab() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF352E60).withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Tiles(
            icon: Icons.logout_outlined,
            title: "Sign Out",
            tail: '',
            method: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => StartingScreen()),
                (route) => false,
              );
            },
          ),
          Divider(),
          InkWell(
            splashColor: Color(0xff9689F2).withOpacity(0.2),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).delete();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => StartingScreen()),
                (route) => false,
              ); //user database thekeo remove kora lagbe
            },
            child: ListTile(
              shape: RoundedRectangleBorder(),
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.delete_outline_rounded, color: Colors.red),
              title: Text(
                "Delete Account",
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
              trailing: Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 28,
                      color: Color(0xff352E60).withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container AccountSettingsTab() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF352E60).withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Tiles(
            method: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: currentPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Current Password',

                            //enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: newPasswordController,
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            //enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: confirmNewPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm New Password',
                            // enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (newPasswordController.text !=
                                confirmNewPasswordController.text) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'New password and confirm password do not match.',
                                  ),
                                ),
                              );
                              newPasswordController.clear();
                              confirmNewPasswordController.clear();
                              currentPasswordController.clear();
                              return;
                            }
                            try {
                              final user = FirebaseAuth.instance.currentUser;
                              AuthCredential credential =
                                  EmailAuthProvider.credential(
                                    email: user!.email!,
                                    password: currentPasswordController.text,
                                  );
                              await user.reauthenticateWithCredential(
                                credential,
                              );

                              await user.updatePassword(
                                newPasswordController.text,
                              );
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Password changed successfully.',
                                  ),
                                ),
                              );
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                                (route) => false,
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'wrong-password') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Current password is incorrect.',
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: ${e.message}'),
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${e.toString()}'),
                                ),
                              );
                            }
                            newPasswordController.clear();
                            confirmNewPasswordController.clear();
                            currentPasswordController.clear();
                          },
                          child: Text('Change Password'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: Icons.lock_outline_rounded,
            title: "Change Password",
            tail: "",
          ),
          Divider(),

          Tiles(
            method: () {},
            icon: Icons.shield_outlined,
            title: "Two-factor Authentication",
            tail: "Off",
          ),
          Divider(),
          Tiles(
            method: () {},
            icon: Icons.mail_outline_rounded,
            title: "Email Address",
            tail: widget.user==null?"loading...":widget.user!.email,
          ),
        ],
      ),
    );
  }

  Container ApearanceSettingsTab() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF352E60).withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Tiles(
            icon: Icons.light_mode_outlined,
            title: "Theme",
            tail: "Light",
            method: () {},
          ),
          Divider(),
          Tiles(
            method: () {},
            icon: Icons.translate_outlined,
            title: "Language",
            tail: "English",
          ),
        ],
      ),
    );
  }

  InkWell Tiles({
    required IconData icon,
    required String title,
    required String tail,
    required VoidCallback method,
  }) {
    return InkWell(
      onTap: method,
      child: ListTile(
        shape: RoundedRectangleBorder(
          //borderRadius: BorderRadius.circular(16),
          //side: BorderSide(color: Color(0xFF352E60).withOpacity(0.1)),
        ),
        contentPadding: EdgeInsets.all(0),
        leading: Icon(icon),
        title: Text("$title", style: TextStyle(fontSize: 14)),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(tail, overflow: TextOverflow.ellipsis),
              Icon(
                Icons.keyboard_arrow_right,
                size: 28,
                color: Color(0xff352E60).withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile PushNotificationToggle() {
    return ListTile(
      // contentPadding: EdgeInsets.all(0),
      leading: Icon(Icons.notifications_none),
      title: Text("Push Notification", style: TextStyle(fontSize: 14)),
      trailing: Switch.adaptive(
        // activeColor: Color(0xff8474F0),
        activeThumbColor: Colors.white,
        activeTrackColor: Color(0xff8474F0),
        inactiveTrackColor: Color(0xff8474F0).withOpacity(0.01),
        inactiveThumbColor: Colors.black12,
        trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => Color(0xFF352E60).withOpacity(0.1),
        ),
        value: pushNotification,
        onChanged: (bool toggleSwicth) {
          setState(() {
            pushNotification = toggleSwicth;
          });
        },
      ),
    );
  }

  ListTile ProfileEditTab() {
    return ListTile(
      //contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(foregroundImage: NetworkImage(widget.user==null?'leading...':widget.user!.profileUrl)),
      title: Text(widget.user==null?'leading...':widget.user!.name),
      subtitle: Text(widget.user==null?'leading...':widget.user!.schoolName),
      trailing: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(
                user: widget.user,
              ),
            ),
          );
        },
        child: Text("Edit", style: TextStyle(fontSize: 12)),
      ),
    );
  }
}
