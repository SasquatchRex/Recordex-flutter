import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/main_provider.dart';
import 'topside.dart';
// import '../../Provider/color_provider.dart';

int activeTileIndexMain = 0;

class LeftSide extends StatefulWidget {
  final bool fullMenu;

  const LeftSide({required this.fullMenu});
  //
  // const LeftSide({required this.fullMenu});
  // const LeftSide({super.key});

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  // Color tileColor = Colors.transparent;
  bool tileActive = false;
  // final GlobalKey<_LeftSideState> leftSideKey = GlobalKey<_LeftSideState>();
  // final bool fullMenu;






  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
      width: widget.fullMenu? 0.20 * width : 0.11*width,
      height: height,
      color: Provider.of<AppColors>(context).appColors.background,
      child: Padding(
        padding: EdgeInsets.only(right: 0.02 * width, left: 0.02 * width),
        child: Column(
          children: [
            SizedBox(
              height: 0.020 * height,
            ),
            CompanyDesc(width),
            SizedBox(
              height: 0.040 * height,
            ),
            Container(
              // height: 0.5*height,
              decoration: BoxDecoration(
                  color: Provider.of<AppColors>(context).appColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20,),
                child: Column(
                  children: [


                    MenuTiles(context,widget.fullMenu, Icons.home, "Dashboard",0),
                    MenuTiles(context,widget.fullMenu, Icons.monetization_on, "Salary Credits",1),
                    MenuTiles(context,widget.fullMenu, Icons.attach_money, "Expense Category 1",2),
                    MenuTiles(context,widget.fullMenu, Icons.attach_money, "Expense Category 2",3),
                    MenuTiles(context,widget.fullMenu, Icons.attach_money, "Company 1 Credits",4),
                    MenuTiles(context,widget.fullMenu, Icons.attach_money, "Company 2 Credits",5),
                    MenuTiles(context,widget.fullMenu, Icons.auto_graph, "Assets",6),
                    MenuTiles(context,widget.fullMenu, Icons.trending_down_outlined, "Liabilities",7),
                    MenuTiles(context,widget.fullMenu, Icons.settings, "Settings",8),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // child: Text("Hello"),
    );
  }

  Padding MenuTiles(BuildContext context, bool fullMenu_wid, IconData icon, String text, int index) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Color tileColor=Colors.transparent;

    bool isActive = activeTileIndexMain == index;



    return Padding(
      // padding:  EdgeInsets.only(bottom:0.005*height),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: InkWell(
        onTap: () {
          setState(() {
            activeTileIndexMain = index;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: 0.05 * height,
          // width: 0.15*width,
          decoration: BoxDecoration(
            color: isActive ? Provider.of<AppColors>(context).appColors.secondary : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left:10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isActive? Provider.of<AppColors>(context).appColors.Icon :Provider.of<AppColors>(context).appColors.IconNotActive,
                ),
                if(fullMenu_wid )
                SizedBox(
                  width: 30,
                ),
                if(fullMenu_wid)
                Expanded(
                  child: Text(
                    "${text}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: isActive? Provider.of<AppColors>(context).appColors.MenuActive :Provider.of<AppColors>(context).appColors.MenuNotActive,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row CompanyDesc(double width) {

    return Row(
      children: [
        SizedBox(width: 0.01*width,),
        Container(
          child: Image.asset(
            "assets/logo.png",
            width: 0.035 * width,
          ),
          // alignment: Alignment.topRight,
        ),
        SizedBox(
          width: 0.01 * width,
        ),
        if(widget.fullMenu)
        Expanded(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.linear,
                  child: Text(
                    "Recordex",

                    style: TextStyle(
                      color: Provider.of<AppColors>(context).appColors.primaryText,
                      fontSize: 0.015 * width,
                      fontWeight: FontWeight.w700,

                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.linear,
                  width: 0.1 * width,
                  child: Center(
                    child: Text(
                      "For Sasquatch Rex Pvt.ltd",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Provider.of<AppColors>(context).appColors.CompanyDesc,
                        fontSize: 0.006 * width,
                        fontWeight: FontWeight.w100,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
