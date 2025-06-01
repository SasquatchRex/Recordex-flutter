import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED


class Profile_Dash extends StatelessWidget {
  const Profile_Dash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 60.h,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            "assets/profile.png",
            scale: 1.8,
            fit: BoxFit.cover,
          )),
    );
  }
}