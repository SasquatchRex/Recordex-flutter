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
  bool notification = false;




  void toggleMenu() {
    setState(() {
      fullMenu = !fullMenu;
      print(fullMenu);
    });
  }
  void toggleNotification() {
    setState(() {
      notification = !notification;
      print(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if(width<1500){
      setState(() {
        fullMenu =false;
      });
    }
    return MaterialApp(

      home: Scaffold(
        appBar: null,
        body: Container(
          child: Row(
            children: [
              LeftSide(fullMenu : fullMenu),
              Expanded(
                child: RightSide(
                    onToggleMenu: toggleMenu,
                    fullMenu : fullMenu,
                    notification : notification,
                  toggleNotification: toggleNotification,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}






