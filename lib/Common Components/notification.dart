import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../Processing/Provider/main_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED
import 'dart:ui';

late OverlayEntry entry;

void notificationOverlay(BuildContext context) {
  final overlay = Overlay.of(context);

  entry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        // Blurred background
        GestureDetector(
          onTap: entry.remove,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),

        // Notification Panel
        Positioned(
          right: 0,
          top: 80,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 300.w,
            height: 400.h,
            decoration: BoxDecoration(
              color: Provider.of<AppColors>(context).appColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Column(
                children: [
                  Text(
                    "Notifications",
                    style: TextStyle(color: Provider.of<AppColors>(context).appColors.tertiaryText, fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  for (int i = 1; i <= 5; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: GestureDetector(
                        onTap: () {
                          print("Option 1");
                        },
                        child: Container(
                            color: Provider.of<AppColors>(context).appColors.secondary,
                            width: 300.w,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Heading 1",
                                    style: TextStyle(
                                      color: Provider.of<AppColors>(context).appColors.NotificationHeader,
                                      fontSize: 12.sp
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "This is the description for heading 1",
                                    style: TextStyle(color: Provider.of<AppColors>(context).appColors.NotificationBody, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );

  overlay.insert(entry);
}

void hideNotification() {
  entry.remove();
}
