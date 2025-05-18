import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/main_provider.dart';
import 'topside.dart';
// import '../../Provider/color_provider.dart';

int activeTileIndexMain = 0;

class LeftSide extends StatefulWidget {

  const LeftSide({super.key});
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
    final List<MenuItem> menuItemsConstruction = [
      MenuItem(icon: Icons.home, text: "Dashboard"),
      MenuItem(icon: Icons.add_box,text: "Add Stocks"),
      MenuItem(icon: Icons.folder,text: "Manage Stocks"),
      MenuItem(icon: Icons.create_new_folder, text: "Create Expense"),
      MenuItem(icon: Icons.monetization_on, text: "Expense Management"),
      MenuItem(icon: Icons.attach_money, text: "Income & Revenue Tracking"),
      MenuItem(icon: Icons.category, text: "Category Management"),
      MenuItem(icon: Icons.create_new_folder_outlined, text: "Create Invoice"),
      MenuItem(icon: Icons.manage_history, text: "Manage Invoice"),
      MenuItem(icon: Icons.group, text: "Team Collaboration"),
      MenuItem(icon: Icons.report, text: "Reports & Analysis"),
      MenuItem(icon: Icons.money, text: "Bank & Payment Integration"),
      MenuItem(icon: Icons.settings, text: "Settings & Customization"),
    ];
    final List<MenuItem> menuItemsShop = [
      MenuItem(icon: Icons.home, text: "Dashboard"),
      MenuItem(icon: Icons.create_new_folder, text: "Create Expense"),
      MenuItem(icon: Icons.monetization_on, text: "Expense Management"),
      MenuItem(icon: Icons.attach_money, text: "Income & Revenue Tracking"),
      MenuItem(icon: Icons.category, text: "Category Management"),
      MenuItem(icon: Icons.create_new_folder_outlined, text: "Create Invoice"),
      MenuItem(icon: Icons.manage_history, text: "Manage Invoice"),
      MenuItem(icon: Icons.group, text: "Team Collaboration"),
      MenuItem(icon: Icons.report, text: "Reports & Analysis"),
      MenuItem(icon: Icons.money, text: "Bank & Payment Integration"),
      MenuItem(icon: Icons.settings, text: "Settings & Customization"),
    ];

    var menuItems = Provider.of<Data>(context,listen: false).Company_Type == "Construction"? menuItemsConstruction
        :Provider.of<Data>(context,listen: false).Company_Type == "Shop"? menuItemsShop
        : [];


    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
      width: Provider.of<General>(context).fullMenu? 0.20 * width : 0.11*width,
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
                  children: menuItems.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return MenuTiles(
                      item: item,
                      isActive: Provider.of<General>(context).activeTileMenuIndex == index,
                      onTap: () {
                        Provider.of<General>(context, listen: false)
                            .ChangeActiveTileMenuIndex(index);
                      },
                    );
                  }).toList(),

                ),
              ),
            )
          ],
        ),
      ),
      // child: Text("Hello"),
    );
  }



  AnimatedContainer CompanyDesc(double width) {

    return AnimatedContainer(
      duration: Duration(seconds: 1),

      child: Row(
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
          if(Provider.of<General>(context).fullMenu)
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
                        "${Provider.of<Data>(context,listen: false).Company}",
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
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String text;

  const MenuItem({required this.icon, required this.text});
}

class MenuTiles extends StatelessWidget {
  final MenuItem item;
  final bool isActive;
  final VoidCallback onTap;

  const MenuTiles({
    Key? key,
    required this.item,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullMenu = Provider.of<General>(context).fullMenu;
    final appColors = Provider.of<AppColors>(context).appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: 0.05 * MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: isActive ? appColors.secondary : appColors.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: isActive ? appColors.Icon : appColors.IconNotActive,
                ),
                if (fullMenu) ...[
                  const SizedBox(width: 30),
                  Expanded(
                    child: Text(
                      item.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isActive
                            ? appColors.MenuActive
                            : appColors.MenuNotActive,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
