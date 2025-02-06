import 'package:flutter/material.dart';
import 'Components/leftside.dart';
import 'Components/rightside.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // final GlobalKey<_LeftSideMenuState> menuKey = GlobalKey<_LeftSideMenuState>();
  bool fullMenu = true;

  void toggleMenu() {
    setState(() {
      fullMenu = !fullMenu;
      print(fullMenu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: null,
        body: Container(
          child: Row(
            children: [
              LeftSide(fullMenu : fullMenu),
              RightSide(
                  onToggleMenu: toggleMenu,
                  fullMenu : fullMenu
              ),


            ],
          ),
        ),
      ),
    );
  }
}






