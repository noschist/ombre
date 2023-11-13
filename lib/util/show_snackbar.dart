import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MessageType {
  success,
  warning,
  error,
  info,
}

void showSnackBar(BuildContext context, String message, MessageType msgType) {
  String msgTitle;
  if (msgType == MessageType.info) {
    msgTitle = "Hi there!";
  } else if (msgType == MessageType.error) {
    msgTitle = "Oh snap!";
  } else if (msgType == MessageType.warning) {
    msgTitle = "Warning";
  } else {
    msgTitle = "Well done!";
  }
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.none,
    dismissDirection: DismissDirection.horizontal,
    content: Stack(
      children: [
        if (msgType == MessageType.info)
          Image.asset("lib/images/msg/info.png")
        else if (msgType == MessageType.error)
          Image.asset("lib/images/msg/error.png")
        else if (msgType == MessageType.warning)
          Image.asset("lib/images/msg/warning.png")
        else
          Image.asset("lib/images/msg/success.png"),
        Positioned(
          top: 60.h,
          left: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                msgTitle,
                style: TextStyle(fontSize: 30.sp),
              ),
              SizedBox(height: 5.h),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: Text(message, style: TextStyle(fontSize: 17.sp))),
            ],
          ),
        )
      ],
    ),
  ));
}
