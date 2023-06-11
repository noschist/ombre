import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ombre/pages/register_page.dart';
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
            alignment: const Alignment(-0.88, 0.4),
            child: SmoothPageIndicator(
              onDotClicked: (index) {
                _controller.jumpToPage(index);
              },
              controller: _controller,
              count: 2,
              effect: const WormEffect(
                  type: WormType.underground,
                  radius: 8,
                  dotHeight: 8,
                  dotWidth: 8),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 105.w),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(70.h),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF2438a4)),
                  onPressed: () {},
                  child: Text(
                    "Login",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.w),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(70.h),
                    side:
                        const BorderSide(width: 2.0, color: Color(0xFF2438a4)),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    foregroundColor: const Color(0xFF2438a4),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(_createRoute());
                  },
                  child: Text(
                    "Create Account",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ))),
        ],
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
