import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ombre/pages/screens/intro_login.dart';
import 'package:ombre/pages/screens/intro_one.dart';
import 'package:ombre/pages/screens/intro_two.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //controller for keeping track of page
  final PageController _controller = PageController();

  bool reachedLoginPage = false;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
                reachedLoginPage = (index == 1);
              });
            },
            children: const [IntroOne(), IntroTwo()],
          ),
          Container(
            alignment: const Alignment(0, 0.32),
            child: SmoothPageIndicator(
              onDotClicked: (index) {
                _controller.jumpToPage(index);
              },
              controller: _controller,
              count: 2,
              effect: const WormEffect(type: WormType.underground),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(30.r),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 15.h),
                      backgroundColor: const Color.fromARGB(255, 0, 80, 172)),
                  onPressed: () {
                    if (reachedLoginPage) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const IntroLogin();
                      }));
                    } else {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }
                  },
                  child: Text(
                    reachedLoginPage ? "Create Account" : "Get Started",
                    style: TextStyle(fontSize: 18.sp),
                  )))
        ],
      ),
    );
  }
}
