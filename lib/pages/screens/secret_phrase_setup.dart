import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterFormTwo extends StatefulWidget {
  final String userName, loginPass;
  const RegisterFormTwo(
      {super.key, required this.userName, required this.loginPass});

  @override
  State<RegisterFormTwo> createState() => _RegisterFormTwoState();
}

class _RegisterFormTwoState extends State<RegisterFormTwo> {
  final _registerFormKey = GlobalKey<FormState>();

  final TextEditingController _emailEditController = TextEditingController();
  final TextEditingController _secretEditController = TextEditingController();

  bool _isSecretVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create Secret Key",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp),
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            "Your Email-Id",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _emailEditController,
            cursorColor: const Color(0xFF2438a4),
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (RegExp(
                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value!)) {
                return null;
              } else {
                return "Please fill in a valid email-id";
              }
            },
            style: const TextStyle(color: Color(0xFF2438a4)),
            decoration: InputDecoration(
              hintText: "abc@xyz.com",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(30.r)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF2438a4)),
                  borderRadius: BorderRadius.circular(30.r)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFA42424)),
                  borderRadius: BorderRadius.circular(30.r)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFA42424)),
                  borderRadius: BorderRadius.circular(30.r)),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "Your Secret Phrase",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: _secretEditController,
            style: const TextStyle(color: Color(0xFF2438a4)),
            obscureText: !_isSecretVisible,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.length >= 12) {
                return null;
              } else {
                return "Secret should be minimum 12 characters long";
              }
            },
            decoration: InputDecoration(
              hintText: "minimum 12 characters",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              suffixIcon: IconButton(
                splashRadius: 1,
                icon: _isSecretVisible
                    ? const Icon(Icons.visibility, color: Color(0xFF2438a4))
                    : const Icon(Icons.visibility_off,
                        color: Color(0xFFBDBDBD)),
                onPressed: () {
                  setState(() {
                    _isSecretVisible = !_isSecretVisible;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(30.r)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF2438a4)),
                  borderRadius: BorderRadius.circular(30.r)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFA42424)),
                  borderRadius: BorderRadius.circular(30.r)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFA42424)),
                  borderRadius: BorderRadius.circular(30.r)),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          const Text.rich(TextSpan(children: [
            TextSpan(
                text:
                    "The secret phrase will be used to access the main application by adding it as a todo task from anywhere while in secret mode. For example, if your secret is "),
            TextSpan(
                text: "abcdxyz", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ", you can add a todo task "),
            TextSpan(
                text: "/ombre/abcdxyz",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    " to access the app, then with the help of the password you set-up in the previous page, you may unlock the app."),
          ])),
          SizedBox(
            height: 30.h,
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF2438a4),
                minimumSize: Size.fromHeight(60.h),
                side: const BorderSide(width: 2.0, color: Color(0xFF2438a4)),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () {
                if (_registerFormKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Done DOne')),
                  );
                }
              },
              child: Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ))
        ],
      ),
    );
  }
}
