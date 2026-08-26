import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/AppbarWidgets.dart';
import '../widgets/bottomNavigation.dart';
import '../widgets/searchBox.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool pushNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [NotificationButtonForAppBar(context: context)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                SearchBox(lebel: "Search for Settings"),
                //SizedBox(height: 20,),
                ProfileEditTab(),
                SizedBox(height: 20,),
                PushNotificationToggle(),
                SizedBox(height: 20),
                Text("Account", style: TextStyle(color: Color(0xff352E60))),
                AccountSettingsTab(),
                SizedBox(height: 20),
                Text(
                  "Appearance",
                  style: TextStyle(color: Color(0xff352E60)),
                ),
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
            icon: Icons.question_mark_outlined,
            title: "Help & FAQ",
            tail: '',
          ),
          Divider(),
          Tiles(
            icon: Icons.phone_android_rounded,
            title: "App Version",
            tail: '',
          ),
          Divider(),
          Tiles(
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
          Tiles(icon: Icons.logout_outlined, title: "Sign Out", tail: ''),
          Divider(),
          InkWell(
            splashColor: Color(0xff9689F2).withOpacity(0.2),
            onTap: () {},
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
            icon: Icons.lock_outline_rounded,
            title: "Change Password",
            tail: "",
          ),
          Divider(),

          Tiles(
            icon: Icons.shield_outlined,
            title: "Two-factor Authentication",
            tail: "Off",
          ),
          Divider(),
          Tiles(
            icon: Icons.mail_outline_rounded,
            title: "Email Address",
            tail: "example@gmail.com",
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
          Tiles(icon: Icons.light_mode_outlined, title: "Theme", tail: "Light"),
          Divider(),
          Tiles(
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
  }) {
    return InkWell(
      onTap: () {},
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
              Text(
                tail,
                overflow: TextOverflow.ellipsis,
              ),
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
      title: Text("Push Notification",style: TextStyle(fontSize: 14)),
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
      leading: CircleAvatar(foregroundImage: AssetImage('assets/image.jpg')),
      title: Text("Student Name"),
      subtitle: Text("University Name"),
      trailing: OutlinedButton(
        onPressed: () {},
        child: Text("Edit", style: TextStyle(fontSize: 12)),
      ),
    );
  }
}
