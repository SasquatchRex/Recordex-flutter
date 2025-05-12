import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import '../../Provider/main_provider.dart';
import '../topside.dart';
import 'dart:ui';

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
    });
  }

  late OverlayEntry _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
      // width: widget.fullMenu
      //     ? 0.80 * MediaQuery.of(context).size.width
      //     : 0.89 * MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Provider.of<AppColors>(context).appColors.background,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20, right: 0, left: 20),
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
                                              fontSize: 24, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
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
                                              width: 20,
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
                                                      style: TextStyle(fontSize: 18, color: Provider.of<AppColors>(context).appColors.secondaryText),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "13.2k",
                                                      style: TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.w300),
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
                                                      style: TextStyle(fontSize: 18, color: Provider.of<AppColors>(context).appColors.secondaryText),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "10.2k",
                                                      style: TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.w300),
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
                                                        "Total Inoives Created this month : ",
                                                        style: TextStyle(fontSize: 18, color: Provider.of<AppColors>(context).appColors.secondaryText),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "13.2k",
                                                        style: TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.w300),
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
                                                        style: TextStyle(fontSize: 18, color: Provider.of<AppColors>(context).appColors.secondaryText),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "10.2k",
                                                        style: TextStyle(fontSize: 28, color: Colors.red, fontWeight: FontWeight.w300),
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
                                                fontSize: 18, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              "Created Date",
                                              style: TextStyle(
                                                  fontSize: 18, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Total Amount",
                                            style: TextStyle(
                                                fontSize: 18, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Remarks",
                                            style: TextStyle(
                                                fontSize: 18, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
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
                                                fontSize: 18, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w500),
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
                                                    showOverlay(context, item["id"]);
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
                                                                style: TextStyle(fontSize: 16, color: Provider.of<AppColors>(context).appColors.primaryText),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  "${item["date"]}",
                                                                  style: TextStyle(fontSize: 14, color: Provider.of<AppColors>(context).appColors.primaryText),
                                                                )),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                "${item["Total Amount"]}",
                                                                style: TextStyle(fontSize: 14, color: Provider.of<AppColors>(context).appColors.primaryText),
                                                              ),
                                                            ),

                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                "${item["Remarks"]}",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(fontSize: 14, color: Provider.of<AppColors>(context).appColors.primaryText),
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
                                                                      fontSize: 14,
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
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // child: Text("Hello"),
    );
    ;
  }

  void showOverlay(BuildContext context, int id) {
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

                      Column(
                        children: [
                          SizedBox(
                            height: 0.69*height,
                            child: InteractiveViewer(
                              panEnabled: true, // Allow panning
                              scaleEnabled: true, // Allow zooming
                              minScale: 1.0,
                              maxScale: 4.0,

                              child: Image.network(
                                Provider.of<invoiceManagementProvider>(context).Imageurl(id),
                                height: 0.69 * height,
                              ),
                            ),
                          ),

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
