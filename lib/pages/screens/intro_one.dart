import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroOne extends StatelessWidget {
  const IntroOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'lib/images/intro1.jpg',
              fit: BoxFit.fitHeight,
              height: 380.h,
              isAntiAlias: true,
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Welcome to\nOmbre",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                  color: const Color.fromARGB(255, 0, 80, 172)),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Where you can store all your secrets in a secure way and also create strong passwords using the built-in password generator.",
              style: TextStyle(fontSize: 18.sp),
            )
          ],
        ),
      ),
    );
  }
}
