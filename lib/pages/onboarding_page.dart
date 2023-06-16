import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ombre/pages/register_page.dart';

import '../util/logo_with_icon.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              logoWithIcon(showText: false, size: 80),
              Image.asset(
                'lib/images/intro2.png',
                fit: BoxFit.fitHeight,
                height: 380.h,
                isAntiAlias: true,
              ),
              Column(
                children: [
                  Text(
                    "Welcome to Ombre",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                        color: const Color(0xff2b38a4)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Text(
                    "Create an account and access lots of cool features and safeguard your secrets",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF919191)),
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.fromHeight(65.h),
                        shape: const StadiumBorder(),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF2b38a4),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(_createRoute());
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ? ",
                        style: TextStyle(color: Color(0xFF919191)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(_createRoute());
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(color: Color(0xFF2b38a4)),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const RegisterPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
