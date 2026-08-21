import 'package:flutter/material.dart';
import 'package:notehive/Screens/homeScreen.dart';
import 'package:notehive/Screens/pageController.dart';

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
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogo(),
                const SizedBox(height: 64),
                _buildHeader(),
                const SizedBox(height: 32),
                _buildLabel('Email'),
                const SizedBox(height: 8),
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildLabel('Password'),
                const SizedBox(height: 8),
                _buildPasswordField(),
                _buildForgotPassword(),
                const SizedBox(height: 8),
                _buildSignInButton(context),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 20),
                _buildGoogleButton(),
                const SizedBox(height: 14),
                _buildGithubButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildLogo() {
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
      const SizedBox(width: 10),
    ],
  );
}

Widget _buildHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
        'Welcome Back!',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account?',
            style: TextStyle(fontSize: 14, color: Color(0xFF1A1730)),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              // Handle sign up navigation
            },
            child: const Text(
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

Widget _buildLabel(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1A1730),
    ),
  );
}

Widget _buildEmailField() {
  return Container( 
    child: TextFormField(
      decoration:  InputDecoration(
        hintText: 'Enter your email',
        filled: true,
        fillColor: Color(0xFFE6E3FC).withOpacity(0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      obscureText: true,
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

Widget _buildPasswordField() {
  return Container(
    child: TextFormField(
      obscureText: true,
      decoration:  InputDecoration(
        hintText: 'Enter your password',
        filled: true,
        fillColor:  Color(0xFFE6E3FC).withOpacity(0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
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

Widget _buildForgotPassword() {
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

Widget _buildSignInButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        // Handle sign in logic
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pagecontroller()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8474F0),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: const Text(
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

Widget _buildDivider() {
  return Row(
    children: [
      Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
      const SizedBox(width: 8),
      const Text(
        'or',
        style: TextStyle(fontSize: 14, color: Color(0xFF1A1730)),
      ),
      const SizedBox(width: 8),
      Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
    ],
  );
}

Widget _buildGoogleButton() {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {
        // Handle Google sign in logic
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF352E60)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/material-icon-theme_google.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          const Text(
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

Widget _buildGithubButton() {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {
        // Handle GitHub sign in logic
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF352E60)),
        backgroundColor: Color(0xFF000000),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/mdi_github.png', width: 24, height: 24),
          const SizedBox(width: 8),
          const Text(
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
