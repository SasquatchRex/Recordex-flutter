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


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if(width<1500){

      Provider.of<General>(context).fullMenu = false;
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
                    LeftSide(),
                    Expanded(
                      child: RightSide(),
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






