import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/register_pass_check.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.callback});

  final Function(String, String) callback;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameEditController = TextEditingController();
  final TextEditingController _passwordEditController = TextEditingController();
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
            "Create Account",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp),
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            "Your Full Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _nameEditController,
            enableSuggestions: false,
            cursorColor: const Color(0xFF2438a4),
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
            style: const TextStyle(color: Color(0xFF2438a4)),
            decoration: InputDecoration(
              hintText: "John Doe",
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
            "Your Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: _passwordEditController,
            style: const TextStyle(color: Color(0xFF2438a4)),
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
              hintText: "minimum 12 characters",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              suffixIcon: IconButton(
                splashRadius: 1,
                icon: _isPasswordVisible
                    ? const Icon(Icons.visibility, color: Color(0xFF2438a4))
                    : const Icon(Icons.visibility_off,
                        color: Color(0xFFBDBDBD)),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
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
            height: 20.h,
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
                  widget.callback(
                      _nameEditController.text, _passwordEditController.text);
                }
              },
              child: Text(
                "Continue",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ))
        ],
      ),
    );
  }
}
