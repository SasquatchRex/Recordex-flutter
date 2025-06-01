import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Processing/Provider/main_provider.dart';
import '../topside.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_utils/nepali_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED

class ExpenseRightside extends StatefulWidget {
  const ExpenseRightside({super.key});

  @override
  State<ExpenseRightside> createState() => _ExpenseRightsideState();
}

class _ExpenseRightsideState extends State<ExpenseRightside> {
  Future<void> _selectDate(BuildContext context) async {
    final NepaliDateTime? picked = await picker.showMaterialDatePicker(
      context: context,
      initialDate: Provider.of<ExpenseProvider>(context,listen: false).selectedDate ?? NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2100),
    );

    if (picked != null && picked != Provider.of<ExpenseProvider>(context,listen: false).selectedDate) {
      Provider.of<ExpenseProvider>(context,listen: false).update_date(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ExpenseProvider>(context).load();

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
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

                            // color: Colors.white10,
                              alignment: Alignment.topLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 50,right: 50, top: 20,bottom:80),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Expense",
                                        style: TextStyle(
                                            fontSize: 24.sp, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 40,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          NameAutocomplete(
                                            names: Provider.of<ExpenseProvider>(context).name_data,
                                            def_val: "",
                                            valueText: "From",
                                            border: true,
                                            Controller: Provider.of<ExpenseProvider>(context).From_Name,
                                            inputformatter: false,
                                          ),
                                          NameAutocomplete(
                                            names: Provider.of<ExpenseProvider>(context).name_data,
                                            def_val: Provider.of<ExpenseProvider>(context).To_Name.text,
                                            valueText: "To",
                                            border: false,
                                            Controller: Provider.of<ExpenseProvider>(context).To_Name,
                                            inputformatter: false,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          NameAutocomplete(
                                              names: Provider.of<ExpenseProvider>(context).pan_data,
                                              def_val: "",
                                              valueText: "PAN",
                                              border: true,
                                              Controller: Provider.of<ExpenseProvider>(context).From_PAN ,
                                              inputformatter: false
                                          ),
                                          NameAutocomplete(
                                              names: Provider.of<ExpenseProvider>(context).pan_data,
                                              def_val: Provider.of<ExpenseProvider>(context).To_PAN.text,
                                              valueText: "VAT",
                                              border: false,
                                              Controller: Provider.of<ExpenseProvider>(context).To_PAN,
                                              inputformatter: true
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            Provider.of<ExpenseProvider>(context,listen: false).selectedDate == null ? "Date : " : "Selected Date : ${NepaliDateFormat('yyyy-MM-dd').format(Provider.of<ExpenseProvider>(context,listen: false).selectedDate!)}",
                                            style: TextStyle(fontSize: 18.sp, color: Provider.of<AppColors>(context).appColors.primaryText),
                                          ),
                                          SizedBox(width: 20.w),
                                          ElevatedButton(
                                            onPressed: () => _selectDate(context),
                                            style: ElevatedButton.styleFrom(
                                              // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Adjust padding
                                                backgroundColor: Provider.of<AppColors>(context).appColors.quaternary),
                                            child: Text(
                                              'Pick a Date',
                                              style: TextStyle(fontSize: 15.sp, color: Provider.of<AppColors>(context).appColors.primaryText),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      // Header of Invoice
                                      InvoiceHeader(),

                                      SizedBox(height: 20),

                                      // Actual Loop for the items
                                      InvoiceCreate(),

                                      SizedBox(height: 20),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(color: Provider.of<AppColors>(context).appColors.quaternary, shape: BoxShape.circle),
                                            child: IconButton(
                                              onPressed: Provider.of<ExpenseProvider>(context).addRow,
                                              icon: Icon(Icons.add),
                                              color: Provider.of<AppColors>(context).appColors.primaryText,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        // alignment: Alignment.centerRight,
                                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                        color: Colors.white.withOpacity(0.04),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // Intended for remarks of bill Custom Text
                                            Expanded(child: TextField(
                                              controller: Provider.of<ExpenseProvider>(context).RemarksController,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: 5,
                                              cursorColor: Provider.of<AppColors>(context).appColors.MenuActive,
                                              style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  fillColor: Provider.of<AppColors>(context).appColors.primary,
                                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                                  // Change focus border color here
                                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                                  labelText: "Remarks",
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                                                  alignLabelWithHint: true,
                                                  labelStyle: TextStyle(
                                                      color: Provider.of<AppColors>(context).appColors.secondaryText,
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.w400


                                                  )
                                              ),


                                            )),

                                            SizedBox(
                                              width: 100,
                                            ),

                                            // This is right invoice total with VAT discount and all
                                            RightInvoiceTotal(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        // EmployeeDash()
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Final Button for creating invoice
            CreateInvoiceButton(),
            if (Provider.of<General>(context).notification) notificationbox(),
          ],
        ),
      ),
      // child: Text("Hello"),
    );
  }
}


late OverlayEntry _overlayEntry;
void showOverlay(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  _overlayEntry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        GestureDetector(
          onTap: hideOverlay ,
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
          child: Material( // Needed to make it look like a normal widget
            elevation: 4.0,
            color: Colors.transparent,

            child: Container(
                width: 0.55*width,
                height: 0.75*height,
                padding: EdgeInsets.all(20.r)
,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Provider.of<AppColors>(context).appColors.primary,
                ),
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
                      child: ElevatedButton(
                          onPressed:() {
                            Provider.of<ExpenseProvider>(context, listen: false).toJson();
                            Provider.of<ExpenseProvider>(context, listen: false).createExpensePost();
                            hideOverlay();
                            if(Provider.of<InvoicePayment>(context, listen: false).post_response == 200){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Expense Successfully Created',
                                    style: TextStyle(
                                      color: Provider.of<AppColors>(context,listen: false).appColors.primaryText,
                                    ),
                                  ),
                                  duration: Duration(seconds: 4),
                                  backgroundColor: Provider.of<AppColors>(context,listen: false).appColors.success,

                                ),
                              );
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Expense Creation Failed. Contact Admin',
                                    style: TextStyle(
                                      color: Provider.of<AppColors>(context,listen: false).appColors.primaryText,
                                    ),
                                  ),
                                  duration: Duration(seconds: 4),
                                  backgroundColor: Provider.of<AppColors>(context,listen: false).appColors.fail,

                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Adjust padding
                              backgroundColor: Provider.of<AppColors>(context).appColors.success),
                          child: Text(
                            "Expense",
                            style: TextStyle(fontSize: 22.sp, color: Colors.white),
                          )),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: 0.69*height,
                        //   child: InteractiveViewer(
                        //     panEnabled: true, // Allow panning
                        //     scaleEnabled: true, // Allow zooming
                        //     minScale: 1.0,
                        //     maxScale: 4.0,
                        //
                        //     child: Image.network(
                        //       "http://127.0.0.1:8000/invoice/preview/?t=${DateTime.now().millisecondsSinceEpoch}",
                        //       headers: {"Cache-Control": "no-cache"},
                        //
                        //       // "https://static.vecteezy.com/vite/assets/photo-masthead-375-BoK_p8LG.webp",
                        //       height: 0.69 * height,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(width: 50,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Text(
                                  "Total Amount : ",
                                  style: TextStyle(
                                    color: Provider.of<AppColors>(context).appColors.primaryText,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Rs. ${Provider.of<InvoicePayment>(context).totalAmountControllers.text}",
                                  style: TextStyle(
                                    color: Provider.of<AppColors>(context).appColors.primaryText,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            SizedBox(
                              height: 250,
                              width: 250,
                              child: Container(
                                // color: Colors.white54,
                                  child: Image.network("https://user-images.githubusercontent.com/11562076/103693127-140e3c80-4f99-11eb-9be1-0aebd6b133bb.png",width: 300,)
                              ),
                            ),
                            SizedBox(height: 30,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Status : ",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Provider.of<AppColors>(context).appColors.primaryText,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                FlutterSwitch(
                                  value: Provider.of<InvoicePayment>(context).Paid,
                                  onToggle:(_) => Provider.of<InvoicePayment>(context,listen: false).togglePaid(),
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
                        )

                      ],
                    ),
                  ],
                )
            ),
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

class CreateInvoiceButton extends StatelessWidget {
  const CreateInvoiceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: ElevatedButton(
          onPressed: () => showOverlay(context),
          // () {
          //   Provider.of<ExpenseProvider>(context, listen: false).toJson();
          //   Provider.of<ExpenseProvider>(context, listen: false).createExpensePost();
          //
          // },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Adjust padding
              backgroundColor: Provider.of<AppColors>(context).appColors.quaternary),
          child: Text(
            "Expense Invoice",
            style: TextStyle(fontSize: 22.sp, color: Provider.of<AppColors>(context).appColors.primaryText),
          )),
    );
  }
}

class RightInvoiceTotal extends StatelessWidget {
  const RightInvoiceTotal({
    super.key,
  });

  // TextEditingController controllerGrand = Provider.of<ExpenseProvider>(context).grandPriceControllers,

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RightInvoiceComp(Controller: Provider.of<ExpenseProvider>(context).totalPriceControllers,text: 'Total : '),
        SizedBox(
          height: 10,
        ),

        RightInvoiceComp(Controller: Provider.of<ExpenseProvider>(context).discountControllers, text: "Discount % : ",onChanged: Provider.of<ExpenseProvider>(context, listen: false).discountPercentage,),
        SizedBox(height: 10,),
        RightInvoiceComp(Controller: Provider.of<ExpenseProvider>(context).taxable_amount_PriceControllers, text: "Taxable Amount : ",),
        SizedBox(height: 10,),
        RightInvoiceComp(Controller: Provider.of<ExpenseProvider>(context).PriceVATControllers, text: "13% VAT : ",),
        SizedBox(height: 10,),
        RightInvoiceComp(Controller: Provider.of<ExpenseProvider>(context).totalAmountControllers, text: "Total Amount : "),
      ],
    );
  }
}

class RightInvoiceComp extends StatelessWidget {
  final TextEditingController Controller;
  final String text;
  final void Function()? onChanged;

  const RightInvoiceComp({
    super.key,
    required this.Controller,
    required this.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
              flex: 5,
              child: Text(
                "${text}",
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.secondaryText
                ),
              )
          ),
          SizedBox(
            width: 40,
          ),
          Flexible(
            flex: 4,
            child: Container(
              width: 250,
              child: TextField(
                controller: Controller,
                onChanged:(value){ onChanged?.call();},
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                // enabled: false,
                // ✅ Allows only numbers and one decimal point
                cursorColor: Provider.of<AppColors>(context).appColors.MenuActive,
                style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Provider.of<AppColors>(context).appColors.primary,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    // Change focus border color here
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
}

class InvoiceHeader extends StatelessWidget {
  const InvoiceHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "SN",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.secondaryText
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: Text("HS Code",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 8,
            child: Text("Name",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: Text("Quantity",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: Text("Unit",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: Text("Unit Price",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: Text("Total Price",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),

        ],
      ),
    );
  }
}

class InvoiceCreate extends StatelessWidget {
  const InvoiceCreate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.05),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 400), // Set max height
        child: SingleChildScrollView(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Provider.of<ExpenseProvider>(context).expenseItems.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.elasticInOut,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text("${index + 1}",style: TextStyle(
                            color: Provider.of<AppColors>(context).appColors.secondaryText
                        ),),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: Provider.of<ExpenseProvider>(context).HSCodeControllers[index],
                          cursorColor: Provider.of<AppColors>(context).appColors.MenuActive,
                          style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Provider.of<AppColors>(context).appColors.primary,
                              border: OutlineInputBorder(borderSide: BorderSide.none),

                              // Change focus border color here
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 8,
                        child: TextField(
                          controller: Provider.of<ExpenseProvider>(context).nameControllers[index],
                          cursorColor: Provider.of<AppColors>(context).appColors.MenuActive,
                          style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Provider.of<AppColors>(context).appColors.primary,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              // Change focus border color here
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: Provider.of<ExpenseProvider>(context).quantityControllers[index],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                          // ✅ Allows only numbers and one decimal point
                          onChanged: (value) {
                            Provider.of<ExpenseProvider>(context, listen: false).calculateTotalPrice(index);
                          },
                          cursorColor: Provider.of<AppColors>(context).appColors.MenuActive,
                          style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Provider.of<AppColors>(context).appColors.primary,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              // Change focus border color here
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: Provider.of<ExpenseProvider>(context).unitControllers[index],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          cursorColor: Provider.of<AppColors>(context).appColors.MenuActive,
                          style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Provider.of<AppColors>(context).appColors.primary,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              // Change focus border color here
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: Provider.of<ExpenseProvider>(context).rateControllers[index],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                          // ✅ Allows only numbers and one decimal point
                          onChanged: (value) {
                            Provider.of<ExpenseProvider>(context, listen: false).calculateTotalPrice(index);
                          },
                          cursorColor: Provider.of<AppColors>(context).appColors.MenuActive,
                          style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Provider.of<AppColors>(context).appColors.primary,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              // Change focus border color here
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: Provider.of<ExpenseProvider>(context).amountPriceControllers[index],
                          onChanged: (value) {
                            Provider.of<ExpenseProvider>(context, listen: false).grandTotal();
                          },
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                          // ✅ Allows only numbers and one decimal point
                          cursorColor: Provider.of<AppColors>(context).appColors.MenuActive,
                          style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Provider.of<AppColors>(context).appColors.primary,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              // Change focus border color here
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                      IconButton(onPressed: () => Provider.of<ExpenseProvider>(context, listen: false).removeRow(index), icon: Icon(Icons.close)),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class NameAutocomplete extends StatelessWidget {
  final List<String> names;
  final String def_val, valueText;
  final bool border;
  final bool inputformatter;
  final TextEditingController Controller;

  NameAutocomplete({super.key, required this.names, required this.def_val, required this.valueText, required this.border,required this.Controller,required this.inputformatter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          return names.where((name) => name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
        },
        displayStringForOption: (String option) => option,
        onSelected: (String selection) {
          print(Provider.of<ExpenseProvider>(context, listen: false).selectedName);
          Provider.of<ExpenseProvider>(context, listen: false).updateSelectedName(selection);
          print(Provider.of<ExpenseProvider>(context, listen: false).selectedName);
          print('Selected: $selection');
        },
        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
          textEditingController.text = '${def_val}'; // Set default value
          return TextField(
            controller: Controller,
            focusNode: focusNode,
            readOnly: !border,
            inputFormatters:inputformatter? [
              LengthLimitingTextInputFormatter(9), // max 5 digits
              // FilteringTextInputFormatter.digitsOnly, // only digits

            ]: [],
            // enabled: border,
            style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
            decoration: InputDecoration(
              labelText: '${valueText}',
              labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
              border: border
                  ? OutlineInputBorder(
                borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
              )
                  : InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
              ),
            ),
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: Container(
                margin: EdgeInsets.only(top: 0),
                width: 300, // Set custom width for the dropdown
                height: 200,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options.elementAt(index);
                    return ListTile(
                      title: Text(option),
                      onTap: () {
                        onSelected(option);
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}

class notificationbox extends StatelessWidget {
  const notificationbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 80,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 300,
        height: 400,
        decoration: BoxDecoration(
          color: Provider.of<AppColors>(context).appColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Text(
                "Notifications",
                style: TextStyle(color: Provider.of<AppColors>(context).appColors.tertiaryText, fontSize: 20.sp),
              ),
              SizedBox(
                height: 10,
              ),
              for (int i = 1; i <= 5; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: GestureDetector(
                    onTap: () {
                      print("Option 1");
                    },
                    child: Container(
                        color: Provider.of<AppColors>(context).appColors.secondary,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Heading 1",
                                style: TextStyle(
                                  color: Provider.of<AppColors>(context).appColors.NotificationHeader,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "This is the description for heading 1",
                                style: TextStyle(color: Provider.of<AppColors>(context).appColors.NotificationBody, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
