import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ombre/services/auth_methods.dart';
import 'package:provider/provider.dart';

OutlinedButton googleBtn(BuildContext context, {bool isLoginMsg = false}) {
  return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF474747),
        backgroundColor: const Color(0xFFf1f5f6),
        minimumSize: Size.fromHeight(60.h),
        side: const BorderSide(color: Color(0xFFf1f5f6)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      onPressed: () {
        context.read<AuthMethods>().signInWithGoogle(context);
      },
      child: Row(
        children: [
          Image.asset(
            "lib/images/google.png",
            width: 25.w,
          ),
          Expanded(
            child: Center(
              child: Text(
                isLoginMsg ? "Login with Google" : "Sign up with Google",
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          )
        ],
      ));
}
