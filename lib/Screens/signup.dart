import 'package:flutter/material.dart';
import 'package:notehive/Screens/homeScreen.dart';
import 'package:notehive/Screens/login.dart';

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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    institutionController.dispose();
    super.dispose();
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
                _buildLogo(),
                SizedBox(height: 32),
                _buildHeader(context),
                SizedBox(height: 24),
                Center(child: _buildPhotoPicker()),
                SizedBox(height: 24),
                _buildLabel('Full Name'),
                SizedBox(height: 8),
                _buildNameField(),
                SizedBox(height: 20),
                _buildLabel('Email'),
                SizedBox(height: 8),
                _buildEmailField(),
                SizedBox(height: 20),
                _buildLabel('Password'),
                SizedBox(height: 8),
                _buildPasswordField(),
                SizedBox(height: 8),
                _buildConfirmPasswordField(),
                SizedBox(height: 20),
                _buildLabel('Institution/ University'),
                SizedBox(height: 8),
                _buildInstitutionField(),
                SizedBox(height: 24),
                _buildSignUpButton(context),
                SizedBox(height: 24),
                _buildDivider(),
                SizedBox(height: 20),
                _buildGoogleButton(),
                SizedBox(height: 14),
                _buildGithubButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: 'Enter your name here',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Enter your email here',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
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

  Widget _buildConfirmPasswordField() {
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

  Widget _buildInstitutionField() {
    return TextFormField(
      controller: institutionController,
      decoration: InputDecoration(
        hintText: 'Enter your university',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          'assets/logo.png',
          width: 125,
          height: 28,
          fit: BoxFit.contain,
        ),
      ),
      SizedBox(width: 10),
    ],
  );
}

Widget _buildHeader(BuildContext context) {
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

Widget _buildPhotoPicker() {
  return Column(
    children: [
      Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Color(0xFFEFEBFF),
          shape: BoxShape.circle,
          border: Border.all(color:  Color(0xFFB0A8D8), width: 1.5),
        ),
        child:  Icon(
          Icons.person_outline,
          size: 45,
          color: Color(0xFF352E60),
        ),
      ),
       SizedBox(height: 8),
       Text(
        'Add photo (Optional)',
        style: TextStyle(fontSize: 14, color: Color(0xFF1A1730)),
      ),
    ],
  );
}

Widget _buildLabel(String text) {
  return Text(
    text,
    style:  TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1A1730),
    ),
  );
}

Widget _buildSignUpButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Homescreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:  Color(0xFF8474F0),
        padding:  EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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

Widget _buildDivider() {
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

Widget _buildGoogleButton() {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {
        // Handle Google sign up logic
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Color(0xFF352E60)),
        padding: EdgeInsets.symmetric(vertical: 16),
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

Widget _buildGithubButton() {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
