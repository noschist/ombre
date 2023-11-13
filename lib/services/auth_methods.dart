import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:ombre/util/show_snackbar.dart";
import "package:shared_preferences/shared_preferences.dart";

enum AuthStatRes { success, secretPend, failed }

class AuthMethods {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthMethods(this._auth, this._firestore);

  User get user => _auth.currentUser!;

  //For checking authentication result
  late AuthStatRes _resul;

  //State Management
  Stream<User?> get authState => _auth.authStateChanges();

  ///
  /// SIGN UP WITH EMAIL
  ///

  Future<AuthStatRes> signUpWithEmail({
    required String userName,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _resul = AuthStatRes.failed;

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
      if (user != null) {
        await setFireDB(user, userName);
        await saveSecretState(false);
        _resul = AuthStatRes.secretPend;
      }
    } on FirebaseAuthException catch (e) {
      _resul = AuthStatRes.failed;
      if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          showSnackBar(context, 'Email already exists!', MessageType.info);
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, e.message!, MessageType.error);
        }
      }
    }
    return _resul;
  }

  ///
  /// LOG IN WITH EMAIL
  ///

  Future<AuthStatRes> logInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _resul = AuthStatRes.failed;

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (!user!.emailVerified) {
        _resul = AuthStatRes.failed;
        await user.sendEmailVerification();
        if (context.mounted) {
          showSnackBar(context, 'Email not verified!', MessageType.info);
        }
      } else {
        if (context.mounted) {
          final bool isSecretKeySet = await checkIfSecretKeySet(user, context);
          if (isSecretKeySet) {
            _resul = AuthStatRes.success;
            await saveSecretState(true);
          } else {
            _resul = AuthStatRes.secretPend;
            await saveSecretState(false);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      _resul = AuthStatRes.failed;
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        if (context.mounted) {
          showSnackBar(context, 'Please check your email/password.',
              MessageType.warning);
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, e.message!, MessageType.error);
        }
      }
    }
    return _resul;
  }

  Future<AuthStatRes> signInWithGoogle({required BuildContext context}) async {
    _resul = AuthStatRes.failed;
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
        final user = userCredential.user;
        if (context.mounted) {
          final bool isSecretKeySet = await checkIfSecretKeySet(user!, context);
          if (userCredential.additionalUserInfo!.isNewUser || !isSecretKeySet) {
            await setFireDB(user);
            await saveSecretState(false);
            _resul = AuthStatRes.secretPend;
          } else {
            await saveSecretState(true);
            _resul = AuthStatRes.success;
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      _resul = AuthStatRes.failed;
      if (context.mounted) {
        showSnackBar(context, e.message!, MessageType.error);
      }
    }
    return _resul;
  }

  Future<bool> signOut({required BuildContext context}) async {
    bool resul = false;
    try {
      await _auth.signOut();
      resul = true;
    } on FirebaseAuthException catch (e) {
      resul = false;
      if (context.mounted) {
        showSnackBar(context, e.message!, MessageType.error);
      }
    }
    return resul;
  }

  Future<bool> deleteAccount({required BuildContext context}) async {
    bool resul = false;
    try {
      await _auth.currentUser!.delete();
      resul = true;
    } on FirebaseAuthException catch (e) {
      resul = false;
      if (context.mounted) {
        showSnackBar(context, e.message!, MessageType.error);
      }
    }
    return resul;
  }

  Future<AuthStatRes> setUserSecretKey(
      {required BuildContext context, required String secretKey}) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({'secretKey': secretKey});
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "Secret not set! Please try again later.",
            MessageType.error);
      }
    }
    return _resul;
  }

  ///
  /// HELPER FUNCTIONS FOR FIRESTORE
  ///

  Future<void> setFireDB(User user, [String? userName]) async {
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': user.displayName ?? userName,
      'email': user.email,
      'photoUrl': user.photoURL,
      'secretKey': ''
    });
  }

  Future<bool> checkIfSecretKeySet(User user, BuildContext context) async {
    return await _firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .where('secretKey', isEqualTo: '')
        .count()
        .get()
        .then((value) => value.count == 0,
            onError: (e) => showSnackBar(
                context,
                'Unknown error occured! Please try again later',
                MessageType.error));
  }

  Future<void> saveSecretState(bool state) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('secretSet', state);
  }
}
