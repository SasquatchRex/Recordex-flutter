import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/main_provider.dart';

import 'leftside.dart';
import 'HomePage/rightside.dart';


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


    print(AppColors);

    return ChangeNotifierProvider<AppColors>(
      create: (_) => AppColors(),
      child: Consumer<AppColors>(
        builder: (context,appColors,child) {
          final colorsAPP = appColors.appColors;
          return MaterialApp(
            theme: ThemeData.dark(),
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
      ),
    );
  }
}






