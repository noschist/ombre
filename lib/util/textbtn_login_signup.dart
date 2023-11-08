import 'package:flutter/material.dart';

Row textBtnLoginOrSignUp(VoidCallback onTap, {bool isLoginMsg = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        isLoginMsg ? "Already have an account ? " : "New to Ombre ? ",
        style: const TextStyle(color: Color(0xFF919191)),
      ),
      GestureDetector(
        onTap: onTap,
        child: Text(
          isLoginMsg ? "Log In" : "Register",
          style: const TextStyle(color: Color(0xFF2b38a4)),
        ),
      ),
    ],
  );
}
