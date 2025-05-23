import 'dart:ui';

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

  void initState() {
    super.initState();

    // This is where you call your provider method
    Future.microtask(()async {
      await Provider.of<Stocks>(context, listen: false).getStocks();
    });
  }

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
                    // width: widget.fullMenu? 0.6 * MediaQuery.of(context).size.width : 0.69* MediaQuery.of(context).size.width,
                    // color: Colors.red,
                    padding: EdgeInsets.only(right: 30),
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Manage Stocks",
                              style: TextStyle(
                                  fontSize: 24, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 40,),
                            GridView.extent(
                              maxCrossAxisExtent: 200, // number of items per row
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 25,
                              children: Provider.of<Stocks>(context).decoded_response['stocks']
                                  .map<Widget>((item) => GestureDetector(
                                onTap: () {
                                  // print(item);
                                  showOverlay(context, item);
                                },
                                child: Container(
                                  // width: 50,
                                  // height: 50,
                                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Provider.of<AppColors>(context).appColors.primary,
                                    borderRadius: BorderRadius.circular(10),
                                    // border: Border.all(color: item['Remaining Quantity'] < 5 ? Colors.red :item['Remaining Quantity'] < 10? Colors.orange: Colors.green),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: item['Remaining Quantity'] < 5 ? Colors.red :item['Remaining Quantity'] < 10? Colors.orange: Colors.green, // shadow color
                                    //     spreadRadius: 2,  // how wide the shadow spreads
                                    //     blurRadius: 15,    // how blurry the shadow is
                                    //     offset: Offset(0, 2), // position of shadow: x (right), y (down)
                                    //   ),
                                    // ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(" ${item['name']}",
                                          textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 15,
                                            color: Provider.of<AppColors>(context).appColors.secondaryText,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      // SizedBox(height: 10,),
                                      Text(
                                        "H.S Code : ${item['HSCode'].length}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Provider.of<AppColors>(context).appColors.secondaryText,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Text(
                                        "Entries : ${item['stock_entries'].length}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Provider.of<AppColors>(context).appColors.secondaryText,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Text(
                                        "No. of unpaid Stock : ${item['No of unpaid']}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Provider.of<AppColors>(context).appColors.secondaryText,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Unit :  ${item['unit']}",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Provider.of<AppColors>(context).appColors.secondaryText,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text("${item['Remaining Quantity']} left",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,

                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color:item['Remaining Quantity'] ==null? Colors.black
                                                  :item['Remaining Quantity'] < 5? Colors.redAccent
                                                  : item['Remaining Quantity'] < 10? Colors.orange
                                                  : Colors.green,
                                              fontSize: 18,


                                            ),
                                          ),
                                        ],
                                      ),

                                      // SizedBox(height: 10,),

                                      // SizedBox(height: 10,),

                                    ],
                                  ),
                                ),
                              ))
                                  .toList(),
                            )

                          ],
                        ),
                      )
                  ),
                ),

              ],
            ),




          ],
        ),
      ),
      // child: Text("Hello"),
    );
  }
  late OverlayEntry _overlayEntry;

  void showOverlay(BuildContext context, Map Stock) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: hideOverlay,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.3), // Optional darken layer
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Center(
            child: Material(
              // Needed to make it look like a normal widget
              elevation: 4.0,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(),
              child: Container(
                  width: 0.75 * width,
                  height: 0.75 * height,
                  padding: EdgeInsets.all(20),
                  color: Provider.of<AppColors>(context).appColors.primary,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: hideOverlay,
                          icon: Icon(Icons.close, color: Colors.red),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Text(
                              "Stock Detail for ${Stock['name']}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                                color: Provider.of<AppColors>(context).appColors.primaryText
                            ),
                          )
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    // color: Provider.of<AppColors>(context).appColors.secondary,
                                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                    margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                    height: 30,
                                    // width: 0.5*width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex:1,
                                            child: Text(
                                              "S.N.",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Provider.of<AppColors>(context).appColors.primaryText
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex:5,
                                            child: Text(
                                              "Dealer's Name",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Provider.of<AppColors>(context).appColors.primaryText
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex:2,
                                            child: Text(
                                              "Rem. Qty",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Provider.of<AppColors>(context).appColors.primaryText
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex:2,
                                            child: Text(
                                              "Last updated",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Provider.of<AppColors>(context).appColors.primaryText
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Container()
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  SingleChildScrollView(
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: Stock['stock_entries'].length,
                                      itemBuilder: (context,index){
                                        dynamic item = Stock['stock_entries'][index] ;
                                        bool paid = item["Payment Paid"];
                                         return Container(
                                           color: Provider.of<AppColors>(context).appColors.secondary,
                                           padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                                           margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                           // height: 30,
                                           // width: 0.5*width,
                                           child: Row(
                                             children: [
                                               Expanded(
                                                    flex:1,
                                                   child: Text(
                                                       "${index+1}",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Provider.of<AppColors>(context).appColors.secondaryText
                                                        ),
                                                   )
                                               ),
                                               Expanded(
                                                    flex:5,
                                                   child: Text(
                                                       "${item['From Name']}",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Provider.of<AppColors>(context).appColors.secondaryText
                                                        ),
                                                   )
                                               ),
                                               Expanded(
                                                    flex:2,
                                                   child: Text(
                                                       "${item['Quantity']}",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Provider.of<AppColors>(context).appColors.secondaryText
                                                        ),
                                                   )
                                               ),
                                               Expanded(
                                                    flex:2,
                                                   child: Text(
                                                       "${item['Last Updated']}",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Provider.of<AppColors>(context).appColors.secondaryText
                                                        ),
                                                   )
                                               ),
                                               Expanded(
                                                 flex: 1,
                                                 child: Container(
                                                   decoration: BoxDecoration(
                                                       color: paid ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(5)),
                                                   child: Padding(
                                                     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                                     child: Text(
                                                       paid ? "Paid" : "Due",
                                                       textAlign: TextAlign.center,
                                                       maxLines: 1,
                                                       overflow: TextOverflow.ellipsis,
                                                       style: TextStyle(
                                                         fontSize: 14,
                                                         color: Colors.white
                                                         // color: index %2 == 0? Colors.green : Colors.red
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         );
                                      },

                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              color: Provider.of<AppColors>(context).appColors.secondary,
                              width: 0.2*width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Remaining Quantity",
                                          style:TextStyle(
                                              color: Provider.of<AppColors>(context).appColors.secondaryText,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          "${Stock['Remaining Quantity']}",
                                          style:TextStyle(
                                              color:Stock['Remaining Quantity'] >=10?
                                                Colors.green
                                                : Stock['Remaining Quantity'] >=5?
                                                  Colors.orange
                                                    : Colors.red,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 38
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry);
  }



  void hideOverlay() {
    _overlayEntry.remove();
  }
}


