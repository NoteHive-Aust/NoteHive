import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/auth_services.dart';
import 'package:notehive/Screens/homeScreen.dart';
import 'package:notehive/Screens/pageController.dart';
import 'package:notehive/Screens/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void signIn() async {
    try {
      await authServices.value.signIn(email: emailController.text.trim(), password :passwordController.text,);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homescreen()));
    } catch (e) {
      // Handle error
      print('Error creating user: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/loginscreen_background.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding:  EdgeInsets.fromLTRB(24, 0, 24, 32),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logo(),
                SizedBox(height: 64),
                header(context: context),
                SizedBox(height: 32),
                label('Email'),
                SizedBox(height: 8),
                emailField(),
                SizedBox(height: 20),
                label('Password'),
                SizedBox(height: 8),
                passwordField(),
                forgotPassword(),
                SizedBox(height: 8),
                signInButton(context),
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

  Widget header({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Welcome Back!',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account?',
              style: TextStyle(fontSize: 14, color: Color(0xFF1A1730)),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                // Handle sign up navigation
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: Text(
                'Sign Up',
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

  Widget emailField() {
    return Container(
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'Enter your email',
          filled: true,
          fillColor: Color(0xFFE6E3FC).withOpacity(0.3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        //obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          // Add more email validation logic if needed
          return null;
        },
      ),

    );
  }

  Widget passwordField() {
    return Container(
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Enter your password',
          filled: true,
          fillColor: Color(0xFFE6E3FC).withOpacity(0.3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          // Add more password validation logic if needed
          return null;
        },
      ),
    );
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Handle forgot password navigation
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF352E60),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          signIn();

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8474F0),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text(
          'Sign In',
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
        Text(
          'or',
          style: TextStyle(fontSize: 14, color: Color(0xFF1A1730)),
        ),
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
          // Handle Google sign in logic
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFF352E60)),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
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
              'Sign in with Google',
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
          // Handle GitHub sign in logic
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFF352E60)),
          backgroundColor: Color(0xFF000000),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/mdi_github.png', width: 24, height: 24),
            SizedBox(width: 8),
            Text(
              'Sign in with GitHub',
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