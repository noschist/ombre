import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget logoWithIcon({bool showText = false}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: showText
          ? [
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
            ]
          : [
              SizedBox(
                  width: 35.w,
                  height: 35.h,
                  child: Image.asset('lib/images/logo.png')),
            ]);
}
