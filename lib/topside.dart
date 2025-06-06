import 'package:flutter/material.dart';
import '../Processing/Provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'Common Components/notification.dart';
import 'Authentication/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED
import 'package:bitsdojo_window/bitsdojo_window.dart';

// bool fullMenu = true;


class Topside extends StatefulWidget {
  const Topside({super.key});


  // const Topside({super.key});

  @override
  State<Topside> createState() => _TopsideState();
}

class _TopsideState extends State<Topside> {
  // final GlobalKey<_LeftSideState> leftSideKey = GlobalKey<_LeftSideState>();
  TextEditingController _searchController = TextEditingController();



  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 20.w, left: 20.w),
        child: Stack(
          children: [
            // Draggable background area
            Positioned.fill(
              child: MoveWindow(
                child: Container(color: Colors.transparent),
              ),
            ),

            // Your interactive content
            Row(
              children: [
                GestureDetector(
                  onTap: Provider.of<General>(context).toggleMenu,
                  child: Icon(
                    Icons.menu,
                    color: Provider.of<AppColors>(context).appColors.Icon,
                  ),
                ),
                SizedBox(width: 25.w),
                Expanded(
                  child: SearchBox(
                    controller: _searchController,
                    hintText: "Search",
                    onChanged: (query) => print("Search query: $query"),
                    onClear: () => setState(() => _searchController.clear()),
                  ),
                ),
                SizedBox(width: 50.w),
                FlutterSwitch(
                  value: Provider.of<AppColors>(context).isDark,
                  onToggle: (_) => Provider.of<AppColors>(context, listen: false).toggleTheme(),
                  borderRadius: 15,
                  toggleSize: 25.r,
                  height: 40.h,
                  width: 75.w,
                  activeIcon: Icon(Icons.dark_mode, color: Colors.deepPurpleAccent.shade700),
                  inactiveIcon: Icon(Icons.light_mode, color: Colors.yellow[700]),
                  activeColor: Colors.white12,
                  inactiveColor: Colors.black12,
                ),
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: () => notificationOverlay(context),
                  child: Notification(),
                ),
                SizedBox(width: 20.w),
                Profile(),
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: () async {
                    await Provider.of<Login_Provider>(context, listen: false).logout();
                    if (Provider.of<Login_Provider>(context, listen: false).loggedout) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                            (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: Icon(
                    Icons.logout,
                    color: Provider.of<AppColors>(context).appColors.Icon,
                  ),
                ),
                SizedBox(width: 20.w),
                const WindowButtons(),
              ],
            ),
          ],
        ),
      ),
    );

  }
}

class Notification extends StatelessWidget {
  const Notification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
                clipBehavior: Clip.none, // Allows the badge to extend outside the Stack
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: Provider.of<AppColors>(context).appColors.Icon,
                    size: 25, // Adjust size as needed
                  ),
                  Positioned(
                    top: -5, // Position above the icon
                    right: -5, // Position to the right of the icon
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Provider.of<AppColors>(context).appColors.NotificationPing,
                        shape: BoxShape.circle, // Ensures a circular badge
                      ),
                      child: Text(
                        "4",
                        style: TextStyle(
                          color: Provider.of<AppColors>(context).appColors.primaryText,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      height: 30.h,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
              "assets/profile.png",
              scale: 1.8,
              fit: BoxFit.cover,
          )
      ),
    );
  }
}



class SearchBox extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function()? onClear;

  const SearchBox({
    Key? key,
    required this.controller,
    this.hintText = "Search...",
    this.onChanged,
    this.onClear,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20,
      margin: EdgeInsets.all(0.r)
,
      padding: EdgeInsets.symmetric(horizontal: 12.w),

      decoration: BoxDecoration(
        // color: Colors.grey[200],
        color: Provider.of<AppColors>(context).appColors.SearchField,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Provider.of<AppColors>(context).appColors.BoxShadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Provider.of<AppColors>(context).appColors.Icon),
          SizedBox(width: 8.w),
          Expanded(// Ensures the TextField takes up the remaining space

            child: TextField(
              controller: widget.controller,
              cursorColor: Provider.of<AppColors>(context).appColors.tertiaryText,
              style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.tertiaryText
              ),
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,

                hintStyle: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.SearchHint,

                ),

                border: InputBorder.none,


              ),
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            GestureDetector(
              onTap: widget.onClear,
              child: Icon(Icons.clear, color: Provider.of<AppColors>(context).appColors.Icon),
            ),
        ],
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFFEE0000),
    iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
          colors: buttonColors,
          onPressed: maximizeOrRestore,
        )
            : MaximizeWindowButton(
          colors: buttonColors,
          onPressed: maximizeOrRestore,
        ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}


