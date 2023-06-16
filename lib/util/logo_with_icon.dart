import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget logoWithIcon({bool showText = false, int size = 35}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: showText
          ? [
              SizedBox(
                  width: size.w,
                  height: size.h,
                  child: Image.asset(
                    'lib/images/logo.png',
                  )),
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
                  width: size.w,
                  height: size.h,
                  child: Image.asset('lib/images/logo.png')),
            ]);
}
