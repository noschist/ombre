import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroOne extends StatelessWidget {
  const IntroOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Image.asset('lib/images/intro1.jpg'),
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(38.r),
            color: Colors.grey.shade700,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 38.r,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Image.asset('lib/images/logo.png'),
              ),
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          Text(
            "Welcome to Ombre",
            style: GoogleFonts.nunitoSans(
                fontSize: 40.sp, color: const Color.fromARGB(255, 0, 80, 172)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Text(
              "A simple and secure way to store all your secrets with a built-in password generator.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp),
            ),
          )
        ],
      ),
    );
  }
}
