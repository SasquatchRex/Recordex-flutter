import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recordex/Authentication/login.dart';
import 'package:recordex/Employees/employees.dart';
import 'package:recordex/Expense%20Management/expense_management_right_side.dart';
import 'package:recordex/Stock/add%20stock.dart';
import 'package:recordex/Stock/manage%20stocks.dart';
import 'Provider/main_provider.dart';

import 'leftside.dart';
import 'HomePage/homepage_right.dart';
import 'Create Expense/expense_rightside.dart';
import 'Income and Revenue/Income_revenue_right.dart';
import 'Category Management/category_management_rightside.dart';
import 'CreateInvoice//invoice_and_payment_rightside.dart';
import 'CreateInvoice//invoice_create_shop.dart';
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
  void initState() {
    super.initState();

    // This is where you call your provider method
    Future.microtask(() async{
      await Provider.of<CheckToken>(context,listen: false).check();
      if(Provider.of<CheckToken>(context,listen: false).is_valid == true || Provider.of<Login_Provider>(context,listen: false).response_code == 200){
        print("Code goes to if");
        Provider.of<Data>(context,listen: false).get_data();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if(width<1500){
      Provider.of<General>(context).fullMenu = false;
    }

    const pageList_construction = [
      HomepageRightSide(),
      Employees(),
      ExpenseRightside(),
      ExpenseManagementRightSide(),
      IncomeRevenueRightside(),
      CategoryManagementRightSide(),
      InvoicePaymentRightside(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      Settings()
    ];
    const pageList_shop = [
      HomepageRightSide(),
      Employees(),
      AddStocks(),
      ManageStocks(),
      IncomeRevenueRightside(),
      CategoryManagementRightSide(),
      InvoiceCreateShop(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      Settings()
    ];
    const pageList_default= [
      HomepageRightSide(),
      Employees(),
      ExpenseRightside(),
      ExpenseManagementRightSide(),
      IncomeRevenueRightside(),
      CategoryManagementRightSide(),
      InvoicePaymentRightside(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      InvoiceManagementRightSide(),
      Settings()
    ];

    var pageList = Provider.of<Data>(context,listen: false).Company_Type == "Construction"? pageList_construction
        :Provider.of<Data>(context,listen: false).Company_Type == "Shop"? pageList_shop
        : pageList_default;
    // Provider.of<CheckToken>(context,listen: false).check();
    return ChangeNotifierProvider<AppColors>(

      create: (_) => AppColors(),
      child: Consumer3<AppColors,Login_Provider,CheckToken>(
        builder: (context,appColors,login_Provider,check_token,child) {
          // final colorsAPP = appColors.appColors;


          if(Provider.of<Login_Provider>(context,listen: false).response_code == 200 || Provider.of<CheckToken>(context,listen: false).is_valid == true || Provider.of<Login_Provider>(context,listen: false).loggedout ==false ) {


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






