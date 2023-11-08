// ignore_for_file: use_build_context_synchronously
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:ombre/util/show_snackbar.dart";

class AuthMethods {
  final FirebaseAuth _auth;
  AuthMethods(this._auth);

  User get user => _auth.currentUser!;

  //State Management
  Stream<User?> get authState => _auth.authStateChanges();

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      await user?.sendEmailVerification();
      if (context.mounted) {
        showSnackBar(context, 'Check your inbox/spam to verify email.',
            MessageType.info);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'Email already exists!', MessageType.info);
      } else {
        showSnackBar(context, e.message!, MessageType.error);
      }
    }
  }

  Future<void> logInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (!user!.emailVerified) {
        if (context.mounted) {
          showSnackBar(context, 'Email not verified!', MessageType.info);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showSnackBar(
            context, 'Please check your email/password.', MessageType.warning);
      } else {
        showSnackBar(context, e.message!, MessageType.error);
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      if (googleSignInAuthentication?.accessToken != null ||
          googleSignInAuthentication?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication?.accessToken,
            idToken: googleSignInAuthentication?.idToken);
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.additionalUserInfo!.isNewUser) {}
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!, MessageType.error);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!, MessageType.error);
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!, MessageType.error);
    }
  }
}
