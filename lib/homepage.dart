import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recordex/Authentication/login.dart';
import 'Provider/main_provider.dart';

import 'leftside.dart';
import 'HomePage/homepage_right.dart';
import 'Expense Management/expense_rightside.dart';
import 'Income and Revenue/Income_revenue_right.dart';
import 'Category Management/category_management_rightside.dart';
import 'CreateInvoice//invoice_and_payment_rightside.dart';
import 'Invoice Management/invoice_management_right_side.dart';
import 'Settings/settings.dart';
import 'Authentication/login.dart';

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

    const pageList = [
      HomepageRightSide(),
      ExpenseRightside(),
      IncomeRevenueRightside(),
      CategoryManagementRightSide(),
      InvoicePaymentRightside(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      Settings()
    ];

    return ChangeNotifierProvider<AppColors>(
      create: (_) => AppColors(),
      child: Consumer2<AppColors,Login_Provider>(
        builder: (context,appColors,login_Provider,child) {
          // final colorsAPP = appColors.appColors;


          if(Provider.of<Login_Provider>(context,listen: false).response_code == 200) {

            return MaterialApp(

              theme: ThemeData.dark(),
              home: Scaffold(
                appBar: null,
                body: Container(
                  child: Row(
                    children: [
                      LeftSide(),
                      Expanded(
                        child: pageList[Provider
                            .of<General>(context)
                            .activeTileMenuIndex],
                      ),


                    ],
                  ),
                ),
              ),
            );
          }
          else
            return Login();
        }
      ),
    );
  }
}






