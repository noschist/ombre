import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroTwo extends StatelessWidget {
  const IntroTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'lib/images/intro2.png',
              fit: BoxFit.fitHeight,
              height: 380.h,
              isAntiAlias: true,
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Secret Task\nList Mode",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                  color: const Color.fromARGB(255, 0, 80, 172)),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Hide your secrets one step further behind a full-fledged task manager app with collections and date management.",
              style: TextStyle(fontSize: 18.sp),
            )
          ],
        ),
      ),
    );
  }
}
