import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/main_provider.dart';
import '../topside.dart';

class ManageStocks extends StatefulWidget {
  const ManageStocks({super.key});

  @override
  State<ManageStocks> createState() => _ManageStocksState();
}

class _ManageStocksState extends State<ManageStocks> {
  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
      // width: widget.fullMenu
      //     ? 0.80 * MediaQuery.of(context).size.width
      //     : 0.89 * MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Provider.of<AppColors>(context).appColors.background,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0,bottom:20,right: 0,left: 20),
        // padding: const EdgeInsets.only(top: 20,bottom: 20),
        child: Stack(
          children: [
            Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Topside(),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            // width: widget.fullMenu? 0.6 * MediaQuery.of(context).size.width : 0.69* MediaQuery.of(context).size.width,
                            // color: Colors.red,
                              alignment: Alignment.topLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Text(
                                      "Manage Stocks",
                                      style: TextStyle(
                                          fontSize: 24, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                        // EmployeeDash()
                      ],
                    ),
                  ),
                ),

              ],
            ),




          ],
        ),
      ),
      // child: Text("Hello"),
    );;
  }
}
