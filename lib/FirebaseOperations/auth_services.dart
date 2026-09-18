import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

ValueNotifier<AuthServices> authServices = ValueNotifier(AuthServices());

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authstateChanges => firebaseAuth.authStateChanges();

  Stream<Object?>? get authStateChanges => null;


  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
Future<UserCredential> createUser({
  required String email,
  required String password,
})async 
{
  return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
}


  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  

  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
