import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

OutlinedButton primaryBtnFilled(VoidCallback onPressed, String btnText) {
  return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2b38a4),
        minimumSize: Size.fromHeight(60.h),
        side: const BorderSide(color: Color(0xFF2b38a4)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      onPressed: onPressed,
      child: Text(
        btnText,
        style: TextStyle(fontSize: 18.sp),
      ));
}
