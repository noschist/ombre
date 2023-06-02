import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroTwo extends StatelessWidget {
  const IntroTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Image.asset('lib/images/intro2.jpg'),
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
            "Secret Mode",
            style: GoogleFonts.nunitoSans(
                fontSize: 40.sp, color: const Color.fromARGB(255, 0, 80, 172)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Text(
              "Hide your secrets a step further within a full fledged TODO application.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp),
            ),
          )
        ],
      ),
    );
  }
}
