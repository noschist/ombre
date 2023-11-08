import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ombre/pages/login_page.dart';
import 'package:ombre/pages/register_page.dart';

import 'package:ombre/util/logo_with_icon.dart';
import 'package:ombre/util/primarybtn_filled.dart';
import 'package:ombre/util/slidein_anim.dart';
import 'package:ombre/util/textbtn_login_signup.dart';

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
                  primaryBtnFilled(() {
                    Navigator.of(context)
                        .push(createRoute(const RegisterPage()));
                  }, "Get Started"),
                  SizedBox(
                    height: 20.h,
                  ),
                  textBtnLoginOrSignUp(() {
                    Navigator.of(context).push(createRoute(const LoginPage()));
                  }, isLoginMsg: true)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
