import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/main_provider.dart';
import 'PercentageLine.dart';
import '../topside.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';


class Profile_Dash extends StatelessWidget {
  const Profile_Dash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
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