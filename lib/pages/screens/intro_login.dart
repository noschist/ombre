import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroLogin extends StatelessWidget {
  const IntroLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 35.w,
                    height: 35.h,
                    child: Image.asset('lib/images/logo.png')),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Ombre",
                  style: GoogleFonts.nunitoSans(
                      fontSize: 32.sp, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Your personal vault",
              style: TextStyle(fontSize: 15.sp),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
