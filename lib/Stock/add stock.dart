import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:provider/provider.dart';
import '../Provider/main_provider.dart';
import '../topside.dart';

class AddStocks extends StatefulWidget {
  const AddStocks({super.key});

  @override
  State<AddStocks> createState() => _AddStocksState();
}

class _AddStocksState extends State<AddStocks> {

  Future<void> _selectDate(BuildContext context) async {
    final NepaliDateTime? picked = await picker.showMaterialDatePicker(
      context: context,
      initialDate: Provider.of<Stocks>(context,listen: false).selectedDate ?? NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2100),
    );

    if (picked != null && picked != Provider.of<Stocks>(context,listen: false).selectedDate) {
      Provider.of<Stocks>(context,listen: false).update_date(picked);
    }
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            // width: widget.fullMenu? 0.6 * MediaQuery.of(context).size.width : 0.69* MediaQuery.of(context).size.width,
                            // color: Colors.red,
                            padding: EdgeInsets.only(right: 40),
                              alignment: Alignment.topLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Manage Invoices",
                                      style: TextStyle(
                                          fontSize: 24, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
                                    ),

                                    SizedBox(height: 40,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  Provider.of<ExpenseProvider>(context,listen: false).selectedDate == null ? "Added Date : " : "Selected Date : ${NepaliDateFormat('yyyy-MM-dd').format(Provider.of<ExpenseProvider>(context,listen: false).selectedDate!)}",
                                                  style: TextStyle(fontSize: 18, color: Provider.of<AppColors>(context).appColors.primaryText),
                                                ),
                                                SizedBox(width: 20),
                                                ElevatedButton(
                                                  onPressed: () => _selectDate(context),
                                                  style: ElevatedButton.styleFrom(
                                                    // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Adjust padding
                                                      backgroundColor: Provider.of<AppColors>(context).appColors.quaternary),
                                                  child: Text(
                                                    'Pick a Date',
                                                    style: TextStyle(fontSize: 15, color: Provider.of<AppColors>(context).appColors.primaryText),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20,),
                                            NameAutocomplete(
                                              names: [],
                                              def_val: Provider.of<Stocks>(context).BillNo.text,
                                              valueText: "Bill No",
                                              border: true,
                                              Controller: Provider.of<Stocks>(context).BillNo,
                                              inputformatter: false,
                                            ),
                                          ],
                                        ),

                                        Column(
                                          children: [
                                            NameAutocomplete(
                                              names: Provider.of<InvoicePaymentShop>(context).name_data,
                                              def_val: "",
                                              valueText: "Dealer's Name",
                                              border: true,
                                              Controller: Provider.of<Stocks>(context).From_Name,
                                              inputformatter: false,
                                            ),
                                            SizedBox(height: 20,),
                                            NameAutocomplete(
                                                names: Provider.of<InvoicePaymentShop>(context).pan_data,
                                                def_val: Provider.of<Stocks>(context).From_PAN.text,
                                                valueText: "Dealer's PAN",
                                                border: true,
                                                Controller: Provider.of<Stocks>(context).From_PAN,
                                                inputformatter: true
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 40,),
                                    StockHeader(),

                                    StockCreate(),
                                    SizedBox(height: 20,),
                                    Container(
                                      decoration: BoxDecoration(color: Provider.of<AppColors>(context).appColors.quaternary, shape: BoxShape.circle),
                                      child: IconButton(
                                        onPressed: Provider.of<Stocks>(context).addRow,
                                        icon: Icon(Icons.add),
                                        color: Provider.of<AppColors>(context).appColors.primaryText,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: TextField(
                                          controller: Provider.of<Stocks>(context).RemarksController,
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
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400


                                              )
                                          ),


                                        )),

                                        // SizedBox(
                                        //   width: 50,
                                        // ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RightStockCPTotal(),
                                            RightStockSPTotal(),
                                          ],
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 20,),


                                    SizedBox(height: 40,)
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
            CreateInvoiceButton()




          ],
        ),
      ),
      // child: Text("Hello"),
    );
  }
}

class CreateStocksButton extends StatelessWidget {
  const CreateStocksButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: ElevatedButton(
          onPressed: () async{
            if(Provider.of<Stocks>(context, listen: false).isFormComplete()) {
              Provider.of<Stocks>(context, listen: false).toJson();

            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Please fill all required fields.',
                    style: TextStyle(
                      color: Provider.of<AppColors>(context,listen: false).appColors.primaryText,
                    ),
                  ),
                  duration: Duration(seconds: 2),
                  backgroundColor: Provider.of<AppColors>(context,listen: false).appColors.fail,

                ),
              );

            }
          },
          // () {
          //   Provider.of<Stocks>(context, listen: false).toJson();
          //   Provider.of<Stocks>(context, listen: false).createInvoicePost();
          //
          // },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Adjust padding
              backgroundColor: Provider.of<AppColors>(context).appColors.quaternary),
          child: Text(
            "Preview Invoice",
            style: TextStyle(fontSize: 22, color: Provider.of<AppColors>(context).appColors.primaryText),
          )),
    );
  }
}

class StockHeader extends StatelessWidget {
  const StockHeader({
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
            child: Text("Unit Cost Price",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),
          SizedBox(width: 20,),

          Expanded(
            flex: 3,
            child: Text("Total Cost Price",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),
          SizedBox(width: 20,),
          Expanded(
            flex: 3,
            child: Text("Unit Selling Price",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),
          SizedBox(
            width: 20,
          ),

          Expanded(
            flex: 3,
            child: Text("Total Selling Price",style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.secondaryText
            ),),
          ),
          SizedBox(width: 10,)

        ],
      ),
    );
  }
}

class StockCreate extends StatelessWidget {
  const StockCreate({
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
              itemCount: Provider.of<Stocks>(context).invoiceItems.length,
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
                          controller: Provider.of<Stocks>(context).HSCodeControllers[index],
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
                          controller: Provider.of<Stocks>(context).nameControllers[index],
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
                          controller: Provider.of<Stocks>(context).quantityControllers[index],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                          // ✅ Allows only numbers and one decimal point
                          onChanged: (value) {
                            Provider.of<Stocks>(context, listen: false).calculateTotalPrice(index);
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
                          controller: Provider.of<Stocks>(context).unitControllers[index],
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
                          controller: Provider.of<Stocks>(context).rateCPControllers[index],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                          // ✅ Allows only numbers and one decimal point
                          onChanged: (value) {
                            Provider.of<Stocks>(context, listen: false).calculateTotalPrice(index);
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
                          controller: Provider.of<Stocks>(context).CPPriceControllers[index],
                          onChanged: (value) {
                            Provider.of<Stocks>(context, listen: false).grandTotal();
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
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: Provider.of<Stocks>(context).rateSPControllers[index],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                          // ✅ Allows only numbers and one decimal point
                          onChanged: (value) {
                            Provider.of<Stocks>(context, listen: false).calculateTotalPrice(index);
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

                      SizedBox(width: 20,),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: Provider.of<Stocks>(context).SPPriceControllers[index],
                          onChanged: (value) {
                            Provider.of<Stocks>(context, listen: false).grandTotal();
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
                      IconButton(onPressed: () => Provider.of<Stocks>(context, listen: false).removeRow(index), icon: Icon(Icons.close)),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class RightStockCPTotal extends StatelessWidget {
  const RightStockCPTotal({
    super.key,
  });

  // TextEditingController controllerGrand = Provider.of<InvoicePayment>(context).grandPriceControllers,

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Cost Price : ",
          style: TextStyle(
              fontSize: 24, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 20,),

        RightInvoiceComp(Controller: Provider.of<Stocks>(context).totalCPPriceControllers,text: 'Total : '),
        SizedBox(
          height: 10,
        ),

        RightInvoiceComp(Controller: Provider.of<Stocks>(context).discountControllers, text: "Discount % : ",onChanged: Provider.of<Stocks>(context, listen: false).discountPercentage,),
        SizedBox(height: 10,),
        RightInvoiceComp(Controller: Provider.of<Stocks>(context).taxable_amount_PriceControllers, text: "Taxable Amount : ",),
        SizedBox(height: 10,),
        RightInvoiceComp(Controller: Provider.of<Stocks>(context).PriceVATControllers, text: "13% VAT : ",),
        SizedBox(height: 10,),
        RightInvoiceComp(Controller: Provider.of<Stocks>(context).totalAmountControllers, text: "Total Amount : "),
      ],
    );
  }
}

class RightStockSPTotal extends StatelessWidget {
  const RightStockSPTotal({
    super.key,
  });

  // TextEditingController controllerGrand = Provider.of<InvoicePayment>(context).grandPriceControllers,

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Selling  Price : ",
          style: TextStyle(
              fontSize: 24, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 20,),

        RightInvoiceComp(Controller: Provider.of<Stocks>(context).totalSPPriceControllers,text: 'Total : '),
        SizedBox(height: 40,),
        Text(
          "Payment to Dealer",
          style: TextStyle(
              fontSize: 24, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Payment Status : ",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Provider.of<AppColors>(context).appColors.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 10,),
            FlutterSwitch(
              value: Provider.of<Stocks>(context).Paid,
              onToggle:(_) => Provider.of<Stocks>(context,listen: false).togglePaid(),
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
        ),


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
          print(Provider.of<InvoicePaymentShop>(context, listen: false).selectedName);
          Provider.of<InvoicePaymentShop>(context, listen: false).updateSelectedName(selection);
          print(Provider.of<InvoicePaymentShop>(context, listen: false).selectedName);
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
          onPressed: () async{
            if(Provider.of<Stocks>(context, listen: false).isFormComplete()) {
              Provider.of<Stocks>(context, listen: false).toJson();
              Provider.of<Stocks>(context, listen: false).addStockPost();

              // await Provider.of<InvoicePaymentShop>(context, listen: false).previewInvoice();
              // showOverlay(context);
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Please fill all required fields.',
                    style: TextStyle(
                      color: Provider.of<AppColors>(context,listen: false).appColors.primaryText,
                    ),
                  ),
                  duration: Duration(seconds: 2),
                  backgroundColor: Provider.of<AppColors>(context,listen: false).appColors.fail,

                ),
              );

            }
          },
          // () {
          //   Provider.of<InvoicePaymentShop>(context, listen: false).toJson();
          //   Provider.of<InvoicePaymentShop>(context, listen: false).createInvoicePost();
          //
          // },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Adjust padding
              backgroundColor: Provider.of<AppColors>(context).appColors.quaternary),
          child: Text(
            "Add Stocks",
            style: TextStyle(fontSize: 22, color: Provider.of<AppColors>(context).appColors.primaryText,),
          )),
    );
  }
}