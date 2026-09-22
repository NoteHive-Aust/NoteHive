import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notehive/Screens/pageController.dart';
import 'package:notehive/Structures/userStructure.dart' show User;

class EditProfileScreen extends StatefulWidget {
  final User? user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final institutionController = TextEditingController();

  File? pickedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() {
        pickedImage = File(picked.path);
      });
    }
  }

  initState() {
    super.initState();
    nameController.text = widget.user?.name ?? '';
    emailController.text = widget.user?.email ?? '';
    institutionController.text = widget.user?.schoolName ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    institutionController.dispose();
    super.dispose();
  }

  void handleEditProfile() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String profileImageUrl = '';
    if (pickedImage != null) {
      final storageRef = FirebaseStorage.instance.ref().child(
        'profileImages/$uid.jpg',
      );
      await storageRef.putFile(pickedImage!);
      profileImageUrl = await storageRef.getDownloadURL();
    }

    await FirebaseFirestore.instance.collection('Users').doc(uid).update({
      'Name': nameController.text.trim(),
      'Email': emailController.text.trim(),
      'SchoolName': institutionController.text.trim(),
      'ProfileImage': profileImageUrl.isNotEmpty
          ? profileImageUrl
          : widget.user?.profileUrl,
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Pagecontroller()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/loginscreen_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logo(),
                SizedBox(height: 32),
                header(context),
                SizedBox(height: 24),
                Center(child: photoPicker()),
                SizedBox(height: 24),
                label('Full Name'),
                SizedBox(height: 8),
                nameField(),
                SizedBox(height: 20),
                label('Email'),
                SizedBox(height: 8),
                emailField(),
                SizedBox(height: 20),

                label('Institution/ University'),
                SizedBox(height: 8),
                institutionField(),
                SizedBox(height: 24),
                signUpButton(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: 'Enter your name here',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Enter your email here',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget institutionField() {
    return TextFormField(
      controller: institutionController,
      decoration: InputDecoration(
        hintText: 'Enter your university',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget logo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            'assets/Logo.png',
            width: 125,
            height: 28,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Update Account',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  //2
  Widget photoPicker() {
    return GestureDetector(
      onTap: pickImage,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Color(0xFFEFEBFF),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFFB0A8D8), width: 1.5),
                  image: pickedImage != null
                      ? DecorationImage(
                          image: FileImage(pickedImage!),
                          fit: BoxFit.cover,
                        )
                      : widget.user == null
                      ? null
                      : DecorationImage(
                          image: NetworkImage(widget.user!.profileUrl),
                          fit: BoxFit.cover,
                        ),
                ),
                child: (pickedImage == null && widget.user == null)
                    ? Icon(
                        Icons.person_outline,
                        size: 45,
                        color: Color(0xFF352E60),
                      )
                    : null,
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFF8474F0),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Icon(Icons.camera_alt, size: 14, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            pickedImage == null
                ? 'Change photo (Optional)'
                : 'Tap to change photo',
            style: TextStyle(fontSize: 14, color: Color(0xFF1A1730)),
          ),
        ],
      ),
    );
  }

  Widget label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1730),
      ),
    );
  }

  Widget signUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          handleEditProfile();
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8474F0),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget googleButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          // Handle Google sign up logic
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFF352E60)),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/material-icon-theme_google.png',
              width: 24,
              height: 24,
            ),
            SizedBox(width: 8),
            Text(
              'Continue with Google',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF352E60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget githubButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          // Handle GitHub sign up logic
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFF352E60)),
          backgroundColor: Color(0xFF000000),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/mdi_github.png', width: 24, height: 24),
            SizedBox(width: 8),
            Text(
              'Continue with Github',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
