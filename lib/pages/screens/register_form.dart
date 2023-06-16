import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/register_pass_check.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameEditController = TextEditingController();
  final TextEditingController _passwordEditController = TextEditingController();
  final TextEditingController _emailEditController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPassword12CharLong = false;
  bool _hasPassword1Num = false;
  bool _hasPassword1Symbol = false;
  bool _hasPassword1Upper = false;

  onPasswordChanged(String password) {
    setState(() {
      _isPassword12CharLong = false;
      _hasPassword1Num = false;
      _hasPassword1Symbol = false;
      _hasPassword1Upper = false;

      if (password.length >= 12) {
        _isPassword12CharLong = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        _hasPassword1Num = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        _hasPassword1Symbol = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        _hasPassword1Upper = true;
      }
    });
  }

  @override
  void dispose() {
    _nameEditController.dispose();
    _passwordEditController.dispose();
    _emailEditController.dispose();
    super.dispose();
  }

  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign Up",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp),
          ),
          SizedBox(
            height: 40.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _nameEditController,
            enableSuggestions: false,
            cursorColor: const Color(0xFF2b38a4),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.length >= 2) {
                return null;
              } else {
                return "Please fill in your full name";
              }
            },
            style: const TextStyle(color: Color(0xFF2b38a4)),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.person_3_outlined,
              ),
              hintText: "Full name",
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD4D4D4)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2b38a4)),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA42424)),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA42424)),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _emailEditController,
            enableSuggestions: false,
            cursorColor: const Color(0xFF2b38a4),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (RegExp(
                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value!)) {
                return null;
              } else {
                return "Please fill in a valid email id";
              }
            },
            style: const TextStyle(color: Color(0xFF2b38a4)),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.alternate_email_rounded,
              ),
              hintText: "Email ID",
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD4D4D4)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2b38a4)),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA42424)),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA42424)),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          TextFormField(
              textInputAction: TextInputAction.done,
              controller: _passwordEditController,
              style: const TextStyle(color: Color(0xFF2b38a4)),
              obscureText: !_isPasswordVisible,
              onChanged: (password) => onPasswordChanged(password),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (_isPassword12CharLong &&
                    _hasPassword1Num &&
                    _hasPassword1Symbol &&
                    _hasPassword1Upper) {
                  return null;
                } else {
                  return "Please fulfill below criteria";
                }
              },
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.key_outlined),
                suffixIcon: IconButton(
                  splashRadius: 1,
                  icon: _isPasswordVisible
                      ? const Icon(Icons.visibility_outlined,
                          color: Color(0xFF2b38a4))
                      : const Icon(Icons.visibility_off_outlined,
                          color: Color(0xFFBDBDBD)),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD4D4D4)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2b38a4)),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFA42424)),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFA42424)),
                ),
              )),
          SizedBox(
            height: 30.h,
          ),
          passwordChecklist(
              _isPassword12CharLong, "Contains minimum 12 characters"),
          SizedBox(
            height: 10.h,
          ),
          passwordChecklist(_hasPassword1Num, "Contains atleast 1 number"),
          SizedBox(
            height: 10.h,
          ),
          passwordChecklist(_hasPassword1Symbol, "Contains atleast 1 symbol"),
          SizedBox(
            height: 10.h,
          ),
          passwordChecklist(
              _hasPassword1Upper, "Contains atleast 1 uppercase letter"),
          SizedBox(
            height: 50.h,
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF2b38a4),
                minimumSize: Size.fromHeight(60.h),
                side: const BorderSide(color: Color(0xFF2b38a4)),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () {},
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 18.sp),
              )),
          SizedBox(
            height: 30.h,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  // indent: 20.0,
                  endIndent: 12.0,
                  thickness: 1,
                ),
              ),
              Text(
                "OR",
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                child: Divider(
                  indent: 12.0,
                  // endIndent: 20.0,
                  thickness: 1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF474747),
                backgroundColor: const Color(0xFFf1f5f6),
                minimumSize: Size.fromHeight(60.h),
                side: const BorderSide(color: Color(0xFFf1f5f6)),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset(
                    "lib/images/google.png",
                    width: 25.w,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Sign up with Google",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
