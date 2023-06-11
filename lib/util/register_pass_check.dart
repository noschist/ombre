import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget passwordChecklist(bool isAchieved, String msg) {
  return Row(
    children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 20.w,
        height: 20.h,
        decoration: BoxDecoration(
            color: isAchieved ? const Color(0xFF2438a4) : Colors.transparent,
            border: isAchieved
                ? Border.all(color: Colors.transparent)
                : Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(30.r)),
        child: const Center(
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 14,
          ),
        ),
      ),
      SizedBox(
        width: 10.w,
      ),
      Text(
        msg,
        style: TextStyle(
            color: isAchieved ? const Color(0xFF2438a4) : Colors.black),
      )
    ],
  );
}
