import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notehive/FirebaseOperations/auth_services.dart';
import 'package:notehive/Screens/homeScreen.dart';
import 'package:notehive/Screens/login.dart';
import 'package:notehive/Screens/pageController.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    institutionController.dispose();
    super.dispose();
  }

  void handleSignUp() async {
    try {
      final credential = await authServices.value.createUser(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      final uid = credential.user!.uid;

      String profileImageUrl = '';
      if (pickedImage != null) {
        final storageRef = FirebaseStorage.instance.ref().child(
          'profileImages/$uid.jpg',
        );
        await storageRef.putFile(pickedImage!);
        profileImageUrl = await storageRef.getDownloadURL();
      } else {
        profileImageUrl =
            'https://firebasestorage.googleapis.com/v0/b/notehive-a7acc.firebasestorage.app/o/profileImages%2Fman%20(1).jpg?alt=media&token=22ee5edf-a0f1-4a68-a229-b6f549ff519b';
      }

      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'Name': nameController.text.trim(),
        'Email': emailController.text.trim(),
        'SchoolName': institutionController.text.trim(),
        'ProfileImage': profileImageUrl,
        'TotalUploads': 0,
        'RepPoints': 0,
        'MyUploads': [],
        'MemberAt': [],
        'Notifications': [],
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Pagecontroller()),
      );
    } catch (e) {
      print('Error creating user: $e');
    }
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
                label('Password'),
                SizedBox(height: 8),
                passwordField(),
                SizedBox(height: 8),
                confirmPasswordField(),
                SizedBox(height: 20),
                label('Institution/ University'),
                SizedBox(height: 8),
                institutionField(),
                SizedBox(height: 24),
                signUpButton(),
                SizedBox(height: 24),
                divider(),
                SizedBox(height: 20),
                googleButton(),
                SizedBox(height: 14),
                githubButton(),
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

  Widget passwordField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Enter a password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      obscureText: true,
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      controller: confirmPasswordController,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      obscureText: true,
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
          'Create an Account',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: TextStyle(fontSize: 14, color: Color(0xFF1A1730)),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: Text(
                'Log In',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF352E60),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
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
                      : null,
                ),
                child: pickedImage == null
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
                ? 'Add photo (Optional)'
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
          handleSignUp();
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8474F0),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          'Create an Account',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
        SizedBox(width: 8),
        Text('or', style: TextStyle(fontSize: 14, color: Color(0xFF1A1730))),
        SizedBox(width: 8),
        Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
      ],
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
