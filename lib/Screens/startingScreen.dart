import 'package:flutter/material.dart';
import 'package:notehive/Screens/signup.dart';
import 'package:notehive/Screens/login.dart';


class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 18),


                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Image.asset(
                    'assets/Logo.png',
                    width: 105,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 60),

                
                Center(
                  child: Image.asset(
                    'assets/Illustration.png',
                    width: 360,
                    height: 360,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 28),

                // Heading
                const Text(
                  'Share Knowledge,\nGrow Together',
                  style: TextStyle(
                    fontSize: 30,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF18162E),
                    letterSpacing: -0.4,
                  ),
                ),

                const SizedBox(height: 9),

              
                const Text(
                  "Join your department's private hub. Upload notes,\n"
                  "papers, and assignments. Learn faster as a\n"
                  "community.",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.2,
                    letterSpacing: -0.4,
                    color: Color(0xFF8B87A1),
                  ),
                ),

                const SizedBox(height: 18),


                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8067E9),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                
                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const SignupScreen(),
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF7F5FD),
                      foregroundColor: const Color(0xFF211D3D),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: const Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}