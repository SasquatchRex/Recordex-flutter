import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import '../../Processing/Provider/main_provider.dart';
import '../topside.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED

class InvoiceManagementRightSide extends StatefulWidget {
  const InvoiceManagementRightSide({super.key});

  @override
  State<InvoiceManagementRightSide> createState() => _InvoiceManagementRightSideState();
}

class _InvoiceManagementRightSideState extends State<InvoiceManagementRightSide> {
  @override
  void initState() {
    super.initState();

    // This is where you call your provider method
    Future.microtask(() {
      Provider.of<invoiceManagementProvider>(context, listen: false).getInvoices();
      Provider.of<invoiceManagementProvider>(context, listen: false).get_invoice_data();
    });
  }

  late OverlayEntry _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
              // width: widget.fullMenu? 0.6 * MediaQuery.of(context).size.width : 0.69* MediaQuery.of(context).size.width,
              // color: Colors.red,
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 70.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Manage Invoices",
                          style: TextStyle(
                              fontSize: 24.sp, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            onPressed: Provider.of<invoiceManagementProvider>(context).filtermenuchange,
                            icon: Icon(Icons.filter_alt, color: Provider.of<AppColors>(context).appColors.primaryText))
                      ],
                    ),
                  ),

                  // if(Provider.of<invoiceManagementProvider>(context).filtermenu)
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0, top: 10, bottom: 2),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                      height: Provider.of<invoiceManagementProvider>(context).filtermenu ? 50 : 0,
                      decoration:
                          BoxDecoration(color: Provider.of<AppColors>(context).appColors.primary, borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Text("Filter with Date : "),
                            SizedBox(
                              width: 20.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Container(
                      // height: 150,
                      color: Provider.of<AppColors>(context).appColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total Inoives Created this month : ",
                                      style: TextStyle(fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.secondaryText),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "${Provider.of<invoiceManagementProvider>(context, listen: false).totalInvoice}",
                                      style: TextStyle(fontSize: 28.sp, color: Colors.green, fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Total Paid Invoices this month : ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.secondaryText),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${Provider.of<invoiceManagementProvider>(context, listen: false).paidInvoice}",
                                      style: TextStyle(fontSize: 28.sp, color: Colors.green, fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Total Sales this month : ",
                                        style: TextStyle(fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.secondaryText),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Rs. ${Provider.of<invoiceManagementProvider>(context, listen: false).totalSales}",
                                        style: TextStyle(fontSize: 28.sp, color: Colors.green, fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Total Unpaid Invoices this month : ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.secondaryText),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${Provider.of<invoiceManagementProvider>(context, listen: false).unpaidInvoice}",
                                        style: TextStyle(fontSize: 28.sp, color: Colors.red, fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10, right: 40, left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "S.N",
                            style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            "To",
                            style: TextStyle(
                                fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Created Date",
                              style: TextStyle(
                                  fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
                            )),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Remarks",
                            style: TextStyle(
                                fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),

                        Expanded(
                          flex: 1,
                          child: Text(
                            "Status",
                            // textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        // Expanded(
                        //   flex: 1,
                        //     child: Container()
                        // )
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 40),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 400),
                        child: Container(
                          color: Provider.of<AppColors>(context).appColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: ListView.builder(
                              itemCount: Provider.of<invoiceManagementProvider>(context).decoded_response.length,
                              // itemCount: 100,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                dynamic item = Provider.of<invoiceManagementProvider>(context).decoded_response[index];
                                bool paid = item["Payment Paid"];

                                return GestureDetector(
                                  onTap: () {
                                    Provider.of<invoiceManagementProvider>(context,listen: false).updated_paid = paid;
                                    showOverlay(context, item["Invoice Number"],paid);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // color: Provider.of<AppColors>(context).appColors.secondary ,
                                        color: Provider.of<AppColors>(context).appColors.secondary,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "${index + 1}",
                                                style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                "${item["To Name"]}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 16.sp, color: Provider.of<AppColors>(context).appColors.primaryText),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "${item["date"]}",
                                                  style: TextStyle(fontSize: 14.sp, color: Provider.of<AppColors>(context).appColors.primaryText),
                                                )),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "${item["Total Amount"]}",
                                                style: TextStyle(fontSize: 14.sp, color: Provider.of<AppColors>(context).appColors.primaryText),
                                              ),
                                            ),

                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "${item["Remarks"]}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 14.sp, color: Provider.of<AppColors>(context).appColors.primaryText),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
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
                                                      fontSize: 14.sp,
                                                      color: Colors.white
                                                      // color: index %2 == 0? Colors.green : Colors.red
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.menu),
                                                color: Provider.of<AppColors>(context).appColors.primaryText),
                                            // Icon(Icons.menu)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
        // EmployeeDash()
      ],
    );
    ;
  }

  void showOverlay(BuildContext context, String InvoiceNumber,bool paid) {
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
                  width: 0.6 * width,
                  height: 0.75 * height,
                  padding: EdgeInsets.all(20.r)
,
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
                        bottom: 0,
                        right: 0,
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: (){},
                              child: Text(
                                  "Print ",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white
                                  ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.orange),
                              ),

                            ),
                            SizedBox(width: 20,),
                            ElevatedButton(
                              onPressed: (paid == Provider.of<invoiceManagementProvider>(context).updated_paid)? (){} : ()=> Provider.of<invoiceManagementProvider>(context,listen: false).updatepaid(InvoiceNumber),
                              child: Text(
                                "Save ",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green),
                              ),

                            ),
                          ],
                        ),
                      ),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          SizedBox(
                            height: 0.69*height,
                            child: InteractiveViewer(
                              panEnabled: true, // Allow panning
                              scaleEnabled: true, // Allow zooming
                              minScale: 1.0,
                              maxScale: 4.0,

                              child: Image.network(
                                Provider.of<invoiceManagementProvider>(context).Imageurl(InvoiceNumber),
                                headers: {
                                  'Authorization':'Bearer ${Provider.of<Data>(context).access_token}'
                                },
                                height: 0.69 * height,
                              ),
                            ),
                          ),
                          SizedBox(width: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Payment status : ",
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: Provider.of<AppColors>(context).appColors.primaryText
                                ),
                              ),
                              SizedBox(width: 30,),
                              FlutterSwitch(
                                value: Provider.of<invoiceManagementProvider>(context,listen: false).updated_paid,
                                onToggle:(_) => Provider.of<invoiceManagementProvider>(context,listen: false).togglePaid(),
                                borderRadius: 15,
                                toggleSize: 25,
                                height: 30,
                                width: 60,
                                activeIcon: Icon(Icons.check, color: Colors.green),

                                inactiveIcon: Icon(Icons.close, color: Colors.red[700]),
                                activeColor: Colors.green.shade700,
                                inactiveColor: Colors.red,

                              ),
                            ],
                          )

                        ],
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
