import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';

import 'package:recordex/Processing/Hive/hive_main.dart';
import '../../HomePage/color.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';


String url = "http://127.0.0.1:8000/";

String? accessToken;




class General with ChangeNotifier{
  bool fullMenu = true;
  bool notification = false;
  int activeTileMenuIndex = 0;

  void toggleMenu() {
    fullMenu =!fullMenu;
    notifyListeners();
  }

  void ChangeActiveTileMenuIndex(int index){
    activeTileMenuIndex = index;
    notifyListeners();
  }

  void toggleNotification() {
    notification =!notification;
    notifyListeners();
  }

  void getToken() async{
    final tokens = await getAuthTokens();
    accessToken = tokens['accessToken'];
  }


  void printNetworkImage(String InvoiceNumber) async {
    final doc = pw.Document();
    String imageUrl = url + '/invoice/bill/${InvoiceNumber}/';
    final image = await networkImage(
        imageUrl,
      headers: {
          'Authorization': "Bearer $accessToken"
      }
    );

    doc.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero,
        build: (context) => pw.SizedBox(
            child: pw.Image(image,fit: pw.BoxFit.cover),
            width: context.page.pageFormat.width,
            height: context.page.pageFormat.height,

        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => doc.save());
  }

}


// Singleton Theme Manager
class AppColors extends ChangeNotifier {
  static final AppColors _instance = AppColors._internal();
  factory AppColors() => _instance;
  AppColors._internal();

  bool _isDark = true;

  bool get isDark => _isDark;
  dynamic get appColors => _isDark ? AppColorsDark() : AppColorsLight();

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}




class InvoicePayment extends ChangeNotifier{

  List <dynamic> data =[];
  List <String> name_data =[];
  List <String> pan_data = [];
  List <String> address_data = [];
  String? selectedName = null;
  bool Paid = false;
  TextEditingController From_Name = TextEditingController(text: "Gandaki Drilling and Construction Pvt. Ltd");
  TextEditingController From_PAN = TextEditingController(text: "100011010");
  TextEditingController To_Name = TextEditingController();
  TextEditingController To_PAN = TextEditingController(text: '-');
  TextEditingController To_Address = TextEditingController();
  NepaliDateTime selectedDate = NepaliDateTime.now();

  void initializer(BuildContext context){
    final dataProvider = Provider.of<Data>(context,listen: false);
    From_Name = TextEditingController(text:dataProvider.Company );
    From_PAN = TextEditingController(text:dataProvider.PAN );

    notifyListeners();

  }

  void togglePaid(){
    Paid = !Paid;
    notifyListeners();
  }

  String final_pan = "";
  int numcount = 1;

  String def_return_pan(){
    var result = data
        .where((d) => d["name"] == name_data[0])
        .map((d) => d["pan"].toString())
        .join(); // Convert to string and join

    if(selectedName == null){
      print("it is null");
    }
    print("result is ${result}");
    return result;
  }

  void updateSelectedName(String name) {
      selectedName = name;

      final_pan = def_return_pan();
      notifyListeners();
    }



  void load(){
    selectedName = null;
    data.clear();
    name_data.clear();
    pan_data.clear();

    data = [
      { "name" : "Gandaki Drilling and Construction", "pan": 10001,"address":"Baneshwor"},
      { "name" : "Aankura Pvt ltd", "pan": 10101,"address":"Buddhanagar"},
    ];

    for(var i in data){
      name_data.add(i["name"].toString());
      pan_data.add(i["pan"].toString());
      address_data.add(i["address"].toString());
    }
  }



  void update_date(NepaliDateTime date){
    selectedDate = date;
    notifyListeners();
  }



  List<Map<String, dynamic>> invoiceItems = [];
  List<TextEditingController> HSCodeControllers = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> quantityControllers = [];
  List<TextEditingController> rateControllers = [];
  List<TextEditingController> unitControllers = [];
  List<TextEditingController> amountPriceControllers = [];
  TextEditingController totalPriceControllers = TextEditingController();
  TextEditingController taxable_amount_PriceControllers = TextEditingController();
  TextEditingController PriceVATControllers = TextEditingController();
  TextEditingController discountControllers = TextEditingController(text: "0");
  TextEditingController totalAmountControllers = TextEditingController();
  TextEditingController RemarksController = TextEditingController(text: "-");

  void addRow() {
    invoiceItems.add({"hs": "","name": "","unitPrice": "","unit" : "", "quantity": "",  "totalPrice": ""});
    HSCodeControllers.add(TextEditingController(text: "-"));
    nameControllers.add(TextEditingController());
    quantityControllers.add(TextEditingController());
    rateControllers.add(TextEditingController());
    unitControllers.add(TextEditingController(text: "-"));
    amountPriceControllers.add(TextEditingController());
    notifyListeners();
  }

  void removeRow([int? index]) {
    if (index == null) {
      // Clear all rows
      for (var controller in [
        nameControllers,
        HSCodeControllers,
        quantityControllers,
        rateControllers,
        unitControllers,
        amountPriceControllers
      ]) {
        for (var c in controller) {
          c.dispose();
        }
        controller.clear();
      }
      invoiceItems.clear();
      To_Address.clear();
      To_PAN.clear();
      To_Name.clear();
      discountControllers.text = "0";
      RemarksController.text ="-";
    } else {
      // Remove single row
      invoiceItems.removeAt(index);
      nameControllers[index].dispose();
      HSCodeControllers[index].dispose();
      quantityControllers[index].dispose();
      rateControllers[index].dispose();
      unitControllers[index].dispose();
      amountPriceControllers[index].dispose();

      nameControllers.removeAt(index);
      HSCodeControllers.removeAt(index);
      quantityControllers.removeAt(index);
      rateControllers.removeAt(index);
      unitControllers.removeAt(index);
      amountPriceControllers.removeAt(index);
    }


    grandTotal();
    discountPercentage();
    // notifyListeners();
  }

  // Calculate the total price for a row
  void calculateTotalPrice(int index) {
    double quantity = double.tryParse(quantityControllers[index].text) ?? 0;
    double unitPrice = double.tryParse(rateControllers[index].text) ?? 0;
    double totalPrice = quantity * unitPrice;
    amountPriceControllers[index].text = totalPrice.toStringAsFixed(2);
    grandTotal();
    discountPercentage();
  }


  void grandTotal() {
    double total = 0.0;
    for (var controller in amountPriceControllers) {
      double value = double.tryParse(controller.text) ?? 0.0;
      total += value;
    }
    totalPriceControllers.text = total.toStringAsFixed(2);
    // totalamountPriceVATControllers.text = (total + 0.13*total).toStringAsFixed(2);
    notifyListeners();
  }


  void discountPercentage(){
    double totalPrice = double.tryParse(totalPriceControllers.text) ?? 0.0;
    double discountPer = double.tryParse(discountControllers.text) ?? 0.0;


    taxable_amount_PriceControllers.text = (totalPrice-0.01*discountPer*totalPrice).toStringAsFixed(2) ;
    double taxable_amount = double.tryParse(taxable_amount_PriceControllers.text) ?? 0.0;
    PriceVATControllers.text = (0.13*taxable_amount).toStringAsFixed(2);
    double vat_amount = double.tryParse(PriceVATControllers.text) ?? 0.0;
    totalAmountControllers.text = (vat_amount + taxable_amount).toStringAsFixed(2);

    // taxable_amount_PriceControllers.text = totalPrice - double.tryParse(finalAmountControllers.text) ?? 0.0));

    notifyListeners();

  }

  Map<String, dynamic> toJson() {
    return {
      "Invoice Items": List.generate(invoiceItems.length, (index) => {
        "H.S Code" : HSCodeControllers[index].text,
        "Name": nameControllers[index].text,
        "Rate": rateControllers[index].text,
        "Unit": unitControllers[index].text,
        "Quantity": quantityControllers[index].text,
        "Amount": amountPriceControllers[index].text,
      }),
      "Total": totalPriceControllers.text,
      "Taxable Amount":taxable_amount_PriceControllers.text,
      "VAT Amount": PriceVATControllers.text,
      "Discount Percentage": discountControllers.text,
      "Total Amount": totalAmountControllers.text,
      "Remarks": RemarksController.text,

      // "From Name": From_Name.text,
      // "From PAN": From_PAN.text,

      "To Name": To_Name.text,
      "To PAN" : To_PAN.text,
      "Payment Paid":Paid,
      "Address":To_Address.text,
      "Date" :  NepaliDateFormat('yyyy-MM-dd').format(selectedDate)


    };
  }

  bool isFormComplete() {
    // Check if all invoice item fields are filled
    for (int i = 0; i < invoiceItems.length; i++) {
      if (HSCodeControllers[i].text.isEmpty ||
          nameControllers[i].text.isEmpty ||
          rateControllers[i].text.isEmpty ||
          unitControllers[i].text.isEmpty ||
          quantityControllers[i].text.isEmpty ||
          amountPriceControllers[i].text.isEmpty) {
        return false;
      }
    }

    // Check other required fields
    final requiredFields = [
      totalPriceControllers.text,
      taxable_amount_PriceControllers.text,
      PriceVATControllers.text,
      discountControllers.text,
      totalAmountControllers.text,
      RemarksController.text,
      From_Name.text,
      From_PAN.text,
      To_Name.text,
      To_PAN.text,
    ];

    for (final field in requiredFields) {
      if (field.isEmpty) return false;
    }

    // Optionally, check date
    if (selectedDate == null) return false;

    return true;
  }

  Future <void> previewInvoice() async{
    final response = await http.post(
      Uri.parse(url + "/invoice/preview/"),
      body: jsonEncode(toJson()),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization':'Bearer ${accessToken}'
      }
    );
    if(response.statusCode == 200){

      // removeRow();
    }
    print(jsonEncode(toJson()));
    print(response.statusCode);
  }
  int? post_response;
  String? InvoiceNumber;
  Future <void> createInvoicePost() async{
    final response = await http.post(
        Uri.parse(url + "/create/invoice/"),
        body: jsonEncode(toJson()),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization':'Bearer ${accessToken}'
        }
    );
    if(response.statusCode == 200){
      removeRow();
    }
    // print(jsonEncode(toJson()));
    // print(response.statusCode);
    post_response = response.statusCode;
    notifyListeners();

  }

}


class InvoicePaymentShop extends ChangeNotifier{
  TextEditingController From_Name = TextEditingController();
  TextEditingController From_PAN = TextEditingController();

  void initializer(BuildContext context){
    final dataProvider = Provider.of<Data>(context,listen: false);
    From_Name = TextEditingController(text:dataProvider.Company );
    From_PAN = TextEditingController(text:dataProvider.PAN );

    notifyListeners();

  }

  List <dynamic> data =[];
  List <String> name_data =[];
  List <String> pan_data = [];
  List <String> address_data = [];
  String? selectedName = null;
  bool Paid = false;

  TextEditingController To_Name = TextEditingController();
  TextEditingController To_PAN = TextEditingController(text: '-');
  TextEditingController To_Address = TextEditingController();
  NepaliDateTime selectedDate = NepaliDateTime.now();

  void togglePaid(){
    Paid = !Paid;
    notifyListeners();
  }

  String final_pan = "";
  int numcount = 1;

  String def_return_pan(){
    var result = data
        .where((d) => d["name"] == name_data[0])
        .map((d) => d["pan"].toString())
        .join(); // Convert to string and join

    if(selectedName == null){
      print("it is null");
    }
    print("result is ${result}");
    return result;
  }

  void updateSelectedName(String name) {
      selectedName = name;

      final_pan = def_return_pan();
      notifyListeners();
    }



  void load(){
    selectedName = null;
    data.clear();
    name_data.clear();
    pan_data.clear();

    data = [
      { "name" : "Gandaki Drilling and Construction", "pan": 10001,"address":"Baneshwor"},
      { "name" : "Aankura Pvt ltd", "pan": 10101,"address":"Buddhanagar"},
    ];

    for(var i in data){
      name_data.add(i["name"].toString());
      pan_data.add(i["pan"].toString());
      address_data.add(i["address"].toString());
    }
  }



  void update_date(NepaliDateTime date){
    selectedDate = date;
    notifyListeners();
  }



  List<Map<String, dynamic>> invoiceItems = [];
  List<TextEditingController> HSCodeControllers = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> quantityControllers = [];
  List<TextEditingController> rateControllers = [];
  List<TextEditingController> unitControllers = [];
  List<TextEditingController> amountPriceControllers = [];
  List<TextEditingController> idControllers = [];
  TextEditingController totalPriceControllers = TextEditingController();
  TextEditingController taxable_amount_PriceControllers = TextEditingController();
  TextEditingController PriceVATControllers = TextEditingController();
  TextEditingController discountControllers = TextEditingController(text: "0");
  TextEditingController totalAmountControllers = TextEditingController();
  TextEditingController RemarksController = TextEditingController(text: "-");

  void addRow() {
    invoiceItems.add({"hs": "","name": "","unitPrice": "","unit" : "", "quantity": "",  "totalPrice": "","id":""});
    HSCodeControllers.add(TextEditingController(text: "-"));
    nameControllers.add(TextEditingController());
    quantityControllers.add(TextEditingController());
    rateControllers.add(TextEditingController());
    unitControllers.add(TextEditingController(text: "-"));
    amountPriceControllers.add(TextEditingController());
    idControllers.add(TextEditingController());
    notifyListeners();
  }

  void removeRow([int? index]) {
    if (index == null) {
      // Clear all rows
      for (var controller in [
        nameControllers,
        HSCodeControllers,
        quantityControllers,
        rateControllers,
        unitControllers,
        amountPriceControllers,
        idControllers,
      ]) {
        for (var c in controller) {
          c.dispose();
        }
        controller.clear();
      }
      invoiceItems.clear();
      To_Address.clear();
      To_PAN.clear();
      To_Name.clear();
      discountControllers.text = "0";
      RemarksController.text ="-";
    } else {
      // Remove single row
      invoiceItems.removeAt(index);
      nameControllers[index].dispose();
      HSCodeControllers[index].dispose();
      quantityControllers[index].dispose();
      rateControllers[index].dispose();
      unitControllers[index].dispose();
      amountPriceControllers[index].dispose();
      idControllers[index].dispose();

      nameControllers.removeAt(index);
      HSCodeControllers.removeAt(index);
      quantityControllers.removeAt(index);
      rateControllers.removeAt(index);
      unitControllers.removeAt(index);
      amountPriceControllers.removeAt(index);
      idControllers.removeAt(index);
    }


    grandTotal();
    discountPercentage();
    // notifyListeners();
  }

  // Calculate the total price for a row
  void calculateTotalPrice(int index) {
    double quantity = double.tryParse(quantityControllers[index].text) ?? 0;
    double unitPrice = double.tryParse(rateControllers[index].text) ?? 0;
    double totalPrice = quantity * unitPrice;
    amountPriceControllers[index].text = totalPrice.toStringAsFixed(2);
    grandTotal();
    discountPercentage();
  }


  void grandTotal() {
    double total = 0.0;
    for (var controller in amountPriceControllers) {
      double value = double.tryParse(controller.text) ?? 0.0;
      total += value;
    }
    totalPriceControllers.text = total.toStringAsFixed(2);
    // totalamountPriceVATControllers.text = (total + 0.13*total).toStringAsFixed(2);
    notifyListeners();
  }


  void discountPercentage(){
    double totalPrice = double.tryParse(totalPriceControllers.text) ?? 0.0;
    double discountPer = double.tryParse(discountControllers.text) ?? 0.0;


    taxable_amount_PriceControllers.text = (totalPrice-0.01*discountPer*totalPrice).toStringAsFixed(2) ;
    double taxable_amount = double.tryParse(taxable_amount_PriceControllers.text) ?? 0.0;
    PriceVATControllers.text = (0.13*taxable_amount).toStringAsFixed(2);
    double vat_amount = double.tryParse(PriceVATControllers.text) ?? 0.0;
    totalAmountControllers.text = (vat_amount + taxable_amount).toStringAsFixed(2);

    // taxable_amount_PriceControllers.text = totalPrice - double.tryParse(finalAmountControllers.text) ?? 0.0));

    notifyListeners();

  }

  Map<String, dynamic> toJson() {
    return {
      "Invoice Items": List.generate(invoiceItems.length, (index) => {
        "H.S Code" : HSCodeControllers[index].text,
        "Name": nameControllers[index].text,
        "Rate": rateControllers[index].text,
        "Unit": unitControllers[index].text,
        "Quantity": quantityControllers[index].text,
        "Amount": amountPriceControllers[index].text,
        "stock_entry":idControllers[index].text
      }),
      "Total": totalPriceControllers.text,
      "Taxable Amount":taxable_amount_PriceControllers.text,
      "VAT Amount": PriceVATControllers.text,
      "Discount Percentage": discountControllers.text,
      "Total Amount": totalAmountControllers.text,
      "Remarks": RemarksController.text,

      // "From Name": From_Name.text,
      // "From PAN": From_PAN.text,

      "To Name": To_Name.text,
      "To PAN" : To_PAN.text,
      "Payment Paid":Paid,
      "Address":To_Address.text,
      "Date" :  NepaliDateFormat('yyyy-MM-dd').format(selectedDate)


    };
  }

  bool isFormComplete() {
    // Check if all invoice item fields are filled
    for (int i = 0; i < invoiceItems.length; i++) {
      if (HSCodeControllers[i].text.isEmpty ||
          nameControllers[i].text.isEmpty ||
          rateControllers[i].text.isEmpty ||
          unitControllers[i].text.isEmpty ||
          quantityControllers[i].text.isEmpty ||
          amountPriceControllers[i].text.isEmpty) {
        return false;
      }
    }

    // Check other required fields
    final requiredFields = [
      totalPriceControllers.text,
      taxable_amount_PriceControllers.text,
      PriceVATControllers.text,
      discountControllers.text,
      totalAmountControllers.text,
      RemarksController.text,
      From_Name.text,
      From_PAN.text,
      To_Name.text,
      To_PAN.text,
    ];

    for (final field in requiredFields) {
      if (field.isEmpty) return false;
    }

    // Optionally, check date
    if (selectedDate == null) return false;

    return true;
  }

  Future <void> previewInvoice() async{
    final response = await http.post(
      Uri.parse(url + "/invoice/preview/"),
      body: jsonEncode(toJson()),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization':'Bearer ${accessToken}'
      }
    );
    if(response.statusCode == 200){

      // removeRow();
    }
    print(jsonEncode(toJson()));
    print(response.statusCode);
  }
  int? post_response;
  String? InvoiceNumber;
  Future <void> createInvoicePost() async{
    final tokens = await getAuthTokens();
    final accessToken = tokens['accessToken'];
    final response = await http.post(
        Uri.parse(url + "/create/invoice/"),
        body: jsonEncode(toJson()),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization':'Bearer ${accessToken}'
        }
    );
    if(response.statusCode == 200){
      final decoded =jsonDecode(response.body);
      InvoiceNumber = decoded['Invoice Number'];
      print(InvoiceNumber);
      removeRow();
    }
    else{
      // print(response.);
    }
    // print(jsonEncode(toJson()));
    // print(response.statusCode);
    post_response = response.statusCode;
    notifyListeners();

  }

}


class ExpenseProvider extends ChangeNotifier{

  List <dynamic> data =[];
  List <String> name_data =[];
  List <String> pan_data = [];
  String? selectedName = null;
  bool Paid = false;

  String final_pan = "";
  int numcount = 1;


  String def_return_pan(){
    var result = data
        .where((d) => d["name"] == name_data[0])
        .map((d) => d["pan"].toString())
        .join(); // Convert to string and join

    if(selectedName == null){
      print("it is null");
    }
    print("result is ${result}");
    return result;
  }

  void togglePaid(){
    Paid = !Paid;
    notifyListeners();
  }

  void updateSelectedName(String name) {
      selectedName = name;

      final_pan = def_return_pan();
      notifyListeners();
    }



  void load(){
    selectedName = null;
   data.clear();
   name_data.clear();
   pan_data.clear();
    data = [
      { "name" : "Gandaki Drilling and Construction", "pan": 10001},
      { "name" : "Aankura Pvt ltd", "pan": 10101},
    ];

    for(var i in data){
      name_data.add(i["name"].toString());
      pan_data.add(i["pan"].toString());
    }
  }

  TextEditingController From_Name = TextEditingController();
  TextEditingController From_PAN = TextEditingController();
  TextEditingController To_Name = TextEditingController(text: "Gandaki Drilling and Construction");
  TextEditingController To_PAN = TextEditingController(text: "1000001");
  NepaliDateTime selectedDate = NepaliDateTime.now();

  void initializer(BuildContext context){
    final dataProvider = Provider.of<Data>(context,listen: false);
    To_Name = TextEditingController(text:dataProvider.Company );
    To_PAN = TextEditingController(text:dataProvider.PAN );

    notifyListeners();

  }

  void update_date(NepaliDateTime date){
    selectedDate = date;
    notifyListeners();
  }



  List<Map<String, dynamic>> expenseItems = [];
  List<TextEditingController> HSCodeControllers = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> quantityControllers = [];
  List<TextEditingController> rateControllers = [];
  List<TextEditingController> unitControllers = [];
  List<TextEditingController> amountPriceControllers = [];
  TextEditingController totalPriceControllers = TextEditingController();
  TextEditingController taxable_amount_PriceControllers = TextEditingController();
  TextEditingController PriceVATControllers = TextEditingController();
  TextEditingController discountControllers = TextEditingController(text: "0");
  TextEditingController totalAmountControllers = TextEditingController();
  TextEditingController RemarksController = TextEditingController();

  void addRow() {
    expenseItems.add({"hs": "","name": "","unitPrice": "","unit" : "", "quantity": "",  "totalPrice": ""});
    HSCodeControllers.add(TextEditingController(text: "-"));
    nameControllers.add(TextEditingController());
    quantityControllers.add(TextEditingController());
    rateControllers.add(TextEditingController());
    unitControllers.add(TextEditingController(text: "-"));
    amountPriceControllers.add(TextEditingController());
    notifyListeners();
  }

  void removeRow([int? index]) {
    if (index == null) {
      // Clear all rows
      for (var controller in [
        nameControllers,
        HSCodeControllers,
        quantityControllers,
        rateControllers,
        unitControllers,
        amountPriceControllers
      ]) {
        for (var c in controller) {
          c.dispose();
        }
        controller.clear();
      }
      expenseItems.clear();
    } else {
      // Remove single row
      expenseItems.removeAt(index);
      nameControllers[index].dispose();
      HSCodeControllers[index].dispose();
      quantityControllers[index].dispose();
      rateControllers[index].dispose();
      unitControllers[index].dispose();
      amountPriceControllers[index].dispose();

      nameControllers.removeAt(index);
      HSCodeControllers.removeAt(index);
      quantityControllers.removeAt(index);
      rateControllers.removeAt(index);
      unitControllers.removeAt(index);
      amountPriceControllers.removeAt(index);
    }


    grandTotal();
    discountPercentage();
    // notifyListeners();
  }

  // Calculate the total price for a row
  void calculateTotalPrice(int index) {
    double quantity = double.tryParse(quantityControllers[index].text) ?? 0;
    double unitPrice = double.tryParse(rateControllers[index].text) ?? 0;
    double totalPrice = quantity * unitPrice;
    amountPriceControllers[index].text = totalPrice.toStringAsFixed(2);
    grandTotal();
    discountPercentage();
  }


  void grandTotal() {
    double total = 0.0;
    for (var controller in amountPriceControllers) {
      double value = double.tryParse(controller.text) ?? 0.0;
      total += value;
    }
    totalPriceControllers.text = total.toStringAsFixed(2);
    // totalamountPriceVATControllers.text = (total + 0.13*total).toStringAsFixed(2);
    notifyListeners();
  }


  void discountPercentage(){
    double totalPrice = double.tryParse(totalPriceControllers.text) ?? 0.0;
    double discountPer = double.tryParse(discountControllers.text) ?? 0.0;


    taxable_amount_PriceControllers.text = (totalPrice-0.01*discountPer*totalPrice).toStringAsFixed(2) ;
    double taxable_amount = double.tryParse(taxable_amount_PriceControllers.text) ?? 0.0;
    PriceVATControllers.text = (0.13*taxable_amount).toStringAsFixed(2);
    double vat_amount = double.tryParse(PriceVATControllers.text) ?? 0.0;
    totalAmountControllers.text = (vat_amount + taxable_amount).toStringAsFixed(2);

    // taxable_amount_PriceControllers.text = totalPrice - double.tryParse(finalAmountControllers.text) ?? 0.0));

    notifyListeners();

  }

  Map<String, dynamic> toJson() {
    return {
      "Expense Items": List.generate(expenseItems.length, (index) => {
        "H.S Code" : HSCodeControllers[index].text,
        "Name": nameControllers[index].text,
        "Rate": rateControllers[index].text,
        "Unit": unitControllers[index].text,
        "Quantity": quantityControllers[index].text,
        "Amount": amountPriceControllers[index].text,
      }),
      "Total": totalPriceControllers.text,
      "Taxable Amount":taxable_amount_PriceControllers.text,
      "VAT Amount": PriceVATControllers.text,
      "Discount Percentage": discountControllers.text,
      "Total Amount": totalAmountControllers.text,
      "Remarks": RemarksController.text,

      "From Name": From_Name.text,
      "From PAN": From_PAN.text,

      // "To Name": To_Name.text,
      // "To PAN" : To_PAN.text,

      "Payment Paid":Paid,
      "Date" :  NepaliDateFormat('yyyy-MM-dd').format(selectedDate)


    };
  }

  Future <void> createExpensePost() async{
    final tokens = await getAuthTokens();
    final accessToken = tokens['accessToken'];
    final response = await http.post(
      Uri.parse(url + "/create/expense/"),
      body: jsonEncode(toJson()),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization':'Bearer ${accessToken}'
      }
    );
    // if(response.statusCode == 200){
    //   removeRow();
    // }
    print(jsonEncode(toJson()));
    print(response.statusCode);
  }

}


class invoiceManagementProvider extends ChangeNotifier{
  late List<dynamic> decoded_response = [];
  bool filtermenu = false;


  void filtermenuchange(){
    filtermenu = !filtermenu;
    notifyListeners();
  }

  String Imageurl(String InvoiceNumber){
    return url+"/invoice/bill/${InvoiceNumber}/";
  }

  void getInvoices() async{
    final tokens = await getAuthTokens();
    final accessToken = tokens['accessToken'];
    final response = await http.get(
      Uri.parse(url+"/invoices/"),
      headers : {
          'Content-Type' : 'application/json',
          'Authorization':'Bearer ${accessToken}'
        }
    );
    if(response.statusCode == 200) {
      decoded_response = jsonDecode(response.body);
      notifyListeners();
    }
  }
  late int totalInvoice=0;
  late int paidInvoice=0;
  late int unpaidInvoice = 0;
  late double totalSales = 0.0;
  String? access_token = accessToken;
  void get_invoice_data()async{
    final response = await http.get(
      Uri.parse(url+"/data/invoice/"),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer ${accessToken}'
      },
    );
    print(response.statusCode);
    if(response.statusCode == 200){
      Map decoded_response = jsonDecode(response.body);
      print(decoded_response);
      totalInvoice = decoded_response["Total This Month"] ;
      paidInvoice = decoded_response["Paid This Month"];
      unpaidInvoice = decoded_response["Unpaid This Month"] ;
      totalSales = decoded_response["total sale"] ;
      notifyListeners();
      // print(decoded_response["Company"]);
    }
    else{
      Map decoded_response = jsonDecode(response.body);
      print(decoded_response);
    }

  }
  late bool updated_paid;
  void togglePaid(){
    updated_paid = !updated_paid;
    notifyListeners();
  }

  void updatepaid(String InvoiceNumebr)async{

    print("updated");
    final response = await http.post(
      Uri.parse(url+"/invoice/togglepaid/${InvoiceNumebr}/"),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer ${accessToken}'
      },
    );
    print(response.statusCode);
    notifyListeners();
  }



}

class ExpenseManagementProvider extends ChangeNotifier{
  late List<dynamic> decoded_response = [];
  bool filtermenu = false;


  void filtermenuchange(){
    filtermenu = !filtermenu;
    notifyListeners();
  }

  // String Imageurl(String InvoiceNumber){
  //   return url+"/invoice/bill/${InvoiceNumber}/";
  // }

  void getExpenses() async{
    final tokens = await getAuthTokens();
    final accessToken = tokens['accessToken'];
    final response = await http.get(
      Uri.parse(url+"/expenses/"),
      headers : {
          'Content-Type' : 'application/json',
          'Authorization':'Bearer ${accessToken}'
        }
    );
    if(response.statusCode == 200) {
      decoded_response = jsonDecode(response.body);
      notifyListeners();
    }
  }


}





class Login_Provider extends ChangeNotifier{
  TextEditingController username= TextEditingController();
  TextEditingController password= TextEditingController();

  int response_code = 0;
  late String? error_msg = null;
  late Map<String, dynamic> decoded_response;
  late bool loggedin=false;
  late bool loggedout=false;

  Future<int> login(TextEditingController username,TextEditingController password)async{
    String username_text = username.text;
    String password_text = password.text;


    dynamic request = {
      "username": username_text,
      "password": password_text
    };
    final tokens = await getAuthTokens();

    final response = await http.post(
      Uri.parse(url + "/login/"),
      body: jsonEncode(request),
      headers: {
        'Content-Type': 'application/json',
        // Add any additional headers if needed
      },
    );
    response_code = response.statusCode;
    decoded_response = jsonDecode(response.body);
    if(response_code !=200){
      error_msg = decoded_response["error"];
    }
    else if(response_code == 200){
      loggedin = true;
      print(decoded_response);
      String access_token = decoded_response['access'];

      await saveAuthTokens(accessToken: access_token);
    }
    // print(error_msg);
    notifyListeners();
    return response.statusCode;
  }


  Future<int> logout() async{
    print("executed");
    bool error=false;
    final response = await http.post(
      Uri.parse(url + "/logout/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':'Bearer ${accessToken}'
        // Add any additional headers if needed
      },
    );
    try {

      await clearAuthTokens();
      accessToken = "";
      error = false;

      // Add any other cleanup you need to do here
      // For example:
      // - Clear user data
      // - Navigate to login screen
      // - Reset app state
    } catch (e) {
      error = true;
      print(e);
      // Handle error appropriately
    }
    print(response.body);
    if (response.statusCode == 200 && !error){
      accessToken = '';
      loggedout=true;
      loggedin=false;


    } else {
      loggedout=false;
      try{
        await clearAuthTokens();
      } catch(e){
        print(e);
      }
    }
    notifyListeners();
    return response.statusCode;
  }
}




class CheckToken extends ChangeNotifier{
  late bool? is_valid = null;

  Future <void> check() async{
    final tokens = await getAuthTokens();
    final accesstoken = tokens['accessToken'];
    // print("Code has been executed");
    // print("Access token: $accesstoken");

    final response = await http.get(
      Uri.parse(url+"/checktoken/"),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer ${accesstoken}'
      },
    );
    if(response.statusCode == 200){
      is_valid = true;
      accessToken = accesstoken;
    }
    else{
      is_valid = false;
    }
    notifyListeners();
  }

}

class Stocks extends ChangeNotifier {
  List<dynamic> data = [];
  String? selectedName;
  bool paid = false;

  late Map<String, dynamic> decoded_response = {};

  final fromName = TextEditingController();
  final fromPAN = TextEditingController(text: '-');
  final billNo = TextEditingController(text: '-');
  final totalCP = TextEditingController();
  final totalSP = TextEditingController();
  final taxableAmount = TextEditingController();
  final vatAmount = TextEditingController();
  final discount = TextEditingController(text: "0");
  final totalAmount = TextEditingController();
  final remarks = TextEditingController(text: "-");

  NepaliDateTime selectedDate = NepaliDateTime.now();

  List<_InvoiceItem> invoiceItems = [];

  void togglePaid() {
    paid = !paid;
    notifyListeners();
  }

  void updateDate(NepaliDateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void addRow() {
    invoiceItems.add(_InvoiceItem());
    notifyListeners();
  }

  void removeRow([int? index]) {
    if (index == null) {
      invoiceItems.forEach((e) => e.dispose());
      invoiceItems.clear();
      _resetControllers();
    } else if (index < invoiceItems.length) {
      invoiceItems[index].dispose();
      invoiceItems.removeAt(index);
    }
    updateTotals();
  }

  void calculateRowTotal(int index) {
    final item = invoiceItems[index];
    final qty = double.tryParse(item.quantity.text) ?? 0;
    final cp = double.tryParse(item.cpRate.text) ?? 0;
    final sp = double.tryParse(item.spRate.text) ?? 0;
    item.cpTotal.text = (qty * cp).toStringAsFixed(2);
    item.spTotal.text = (qty * sp).toStringAsFixed(2);
    updateTotals();
  }

  void updateTotals() {
    final totalCPVal = invoiceItems.fold(0.0, (sum, e) => sum + (double.tryParse(e.cpTotal.text) ?? 0));
    final totalSPVal = invoiceItems.fold(0.0, (sum, e) => sum + (double.tryParse(e.spTotal.text) ?? 0));

    totalCP.text = totalCPVal.toStringAsFixed(2);
    totalSP.text = totalSPVal.toStringAsFixed(2);

    final discountPercent = double.tryParse(discount.text) ?? 0.0;
    final discounted = totalCPVal - (discountPercent / 100 * totalCPVal);
    taxableAmount.text = discounted.toStringAsFixed(2);

    final vat = discounted * 0.13;
    vatAmount.text = vat.toStringAsFixed(2);
    totalAmount.text = (discounted + vat).toStringAsFixed(2);

    notifyListeners();
  }

  void _resetControllers() {
    fromPAN.clear();
    fromName.clear();
    discount.text = "0";
    remarks.text = "-";
  }

  bool isFormComplete() {
    for (var item in invoiceItems) {
      if (!item.isComplete()) return false;
    }
    return [
      totalCP.text,
      taxableAmount.text,
      vatAmount.text,
      discount.text,
      totalAmount.text,
      remarks.text,
      fromName.text,
      fromPAN.text
    ].every((t) => t.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    return {
      "Stock Items": invoiceItems.map((e) => e.toJson()).toList(),
      "Total Cost Price": totalCP.text,
      "Total Selling Price": totalSP.text,
      "Taxable Amount": taxableAmount.text,
      "VAT Amount": vatAmount.text,
      "Discount Percentage": discount.text,
      "Total Amount": totalAmount.text,
      "Remarks": remarks.text,
      "From Name": fromName.text,
      "From PAN": fromPAN.text,
      "Bill No": billNo.text,
      "Payment Paid": paid,
      "Date": NepaliDateFormat('yyyy-MM-dd').format(selectedDate),
    };
  }
  Future <void> addStockPost() async{
    final response = await http.post(
        Uri.parse(url + "/create/stocks/"),
        body: jsonEncode(toJson()),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization':'Bearer ${accessToken}'
        }
    );
    // if(response.statusCode == 200){
    //   removeRow();
    // }
    // print(jsonEncode(toJson()));
    print(response.statusCode);
    Map decoded_response = jsonDecode(response.body);
    print(decoded_response["message"]);
  }


  Future <void> getStocks() async{
    final response = await http.get(
        Uri.parse(url+"/stocks/"),
        headers : {
          'Content-Type' : 'application/json',
          'Authorization':'Bearer ${accessToken}'
        }
    );

    if(response.statusCode == 200) {
      decoded_response = jsonDecode(response.body);
      // print(decoded_response);
      notifyListeners();
    }

  }
// ... HTTP methods stay the same ...
}

class _InvoiceItem {
  final hsCode = TextEditingController(text: "-");
  final name = TextEditingController();
  final unit = TextEditingController(text: "-");
  final quantity = TextEditingController();
  final cpRate = TextEditingController();
  final spRate = TextEditingController();
  final cpTotal = TextEditingController();
  final spTotal = TextEditingController();

  void dispose() {
    [hsCode, name, unit, quantity, cpRate, spRate, cpTotal, spTotal].forEach((c) => c.dispose());
  }

  bool isComplete() {
    return [hsCode, name, unit, quantity, cpRate, spRate, cpTotal, spTotal].every((c) => c.text.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    return {
      "H.S Code": hsCode.text,
      "Name": name.text,
      "CP Rate": cpRate.text,
      "SP Rate": spRate.text,
      "Unit": unit.text,
      "Quantity": quantity.text,
      "Cost Total": cpTotal.text,
      "Selling Total": spTotal.text,
    };
  }
}

// class Stocks extends ChangeNotifier{
//
//   List <dynamic> data =[];
//   String? selectedName = null;
//   bool Paid = false;
//   TextEditingController From_Name = TextEditingController();
//   TextEditingController From_PAN = TextEditingController(text: '-');
//   TextEditingController BillNo = TextEditingController(text: '-');
//
//
//   void togglePaid(){
//     Paid = !Paid;
//     notifyListeners();
//   }
//
//
//   NepaliDateTime selectedDate = NepaliDateTime.now();
//
//   void update_date(NepaliDateTime date){
//     selectedDate = date;
//     notifyListeners();
//   }
//
//
//
//   List<Map<String, dynamic>> invoiceItems = [];
//   List<TextEditingController> HSCodeControllers = [];
//   List<TextEditingController> nameControllers = [];
//   List<TextEditingController> quantityControllers = [];
//   List<TextEditingController> rateCPControllers = [];
//   List<TextEditingController> rateSPControllers = [];
//   List<TextEditingController> unitControllers = [];
//   List<TextEditingController> CPPriceControllers = [];
//   List<TextEditingController> SPPriceControllers = [];
//   TextEditingController totalCPPriceControllers = TextEditingController();
//   TextEditingController totalSPPriceControllers = TextEditingController();
//   TextEditingController taxable_amount_PriceControllers = TextEditingController();
//   TextEditingController PriceVATControllers = TextEditingController();
//   TextEditingController discountControllers = TextEditingController(text: "0");
//   TextEditingController totalAmountControllers = TextEditingController();
//   TextEditingController RemarksController = TextEditingController(text: "-");
//
//   void addRow() {
//     invoiceItems.add({"hs": "","name": "","unitPrice": "","unitCP" : "","unitSP":"", "quantity": "",  "Cost Price": "", "Selling Price":""});
//     HSCodeControllers.add(TextEditingController(text: "-"));
//     nameControllers.add(TextEditingController());
//     quantityControllers.add(TextEditingController());
//     rateCPControllers.add(TextEditingController());
//     rateSPControllers.add(TextEditingController());
//     unitControllers.add(TextEditingController(text: "-"));
//     CPPriceControllers.add(TextEditingController());
//     SPPriceControllers.add(TextEditingController());
//     notifyListeners();
//   }
//
//   void removeRow([int? index]) {
//     if (index == null) {
//       // Clear all rows
//       for (var controller in [
//         nameControllers,
//         HSCodeControllers,
//         quantityControllers,
//         rateCPControllers,
//         rateSPControllers,
//         unitControllers,
//         CPPriceControllers,
//         SPPriceControllers
//       ]) {
//         for (var c in controller) {
//           c.dispose();
//         }
//         controller.clear();
//       }
//       invoiceItems.clear();
//       From_PAN.clear();
//       From_Name.clear();
//       discountControllers.text = "0";
//       RemarksController.text ="-";
//     } else {
//       // Remove single row
//       invoiceItems.removeAt(index);
//       nameControllers[index].dispose();
//       HSCodeControllers[index].dispose();
//       quantityControllers[index].dispose();
//       rateCPControllers[index].dispose();
//       rateSPControllers[index].dispose();
//       unitControllers[index].dispose();
//       CPPriceControllers[index].dispose();
//       SPPriceControllers[index].dispose();
//
//       nameControllers.removeAt(index);
//       HSCodeControllers.removeAt(index);
//       quantityControllers.removeAt(index);
//       rateCPControllers.removeAt(index);
//       rateSPControllers.removeAt(index);
//       unitControllers.removeAt(index);
//       CPPriceControllers.removeAt(index);
//       SPPriceControllers.removeAt(index);
//     }
//
//
//     grandTotal();
//     discountPercentage();
//     // notifyListeners();
//   }
//
//   // Calculate the total price for a row
//   void calculateTotalPrice(int index) {
//     double quantity = double.tryParse(quantityControllers[index].text) ?? 0;
//     double unitCPPrice = double.tryParse(rateCPControllers[index].text) ?? 0;
//     double unitSPPrice = double.tryParse(rateSPControllers[index].text) ?? 0;
//     double totalCPPrice = quantity * unitCPPrice;
//     double totalSPPrice = quantity * unitSPPrice;
//     CPPriceControllers[index].text = totalCPPrice.toStringAsFixed(2);
//     SPPriceControllers[index].text = totalSPPrice.toStringAsFixed(2);
//     grandTotal();
//     discountPercentage();
//   }
//
//
//   void grandTotal() {
//     double totalCP = 0.0;
//     double totalSP = 0.0;
//     for (var controller in CPPriceControllers) {
//       double value = double.tryParse(controller.text) ?? 0.0;
//       totalCP += value;
//     }
//     for (var controller in SPPriceControllers) {
//       double valueSP = double.tryParse(controller.text) ?? 0.0;
//       totalSP += valueSP;
//     }
//     totalCPPriceControllers.text = totalCP.toStringAsFixed(2);
//     totalSPPriceControllers.text = totalSP.toStringAsFixed(2);
//     // totalamountPriceVATControllers.text = (total + 0.13*total).toStringAsFixed(2);
//     notifyListeners();
//   }
//
//
//   void discountPercentage(){
//     double totalPrice = double.tryParse(totalCPPriceControllers.text) ?? 0.0;
//     double discountPer = double.tryParse(discountControllers.text) ?? 0.0;
//
//
//     taxable_amount_PriceControllers.text = (totalPrice-0.01*discountPer*totalPrice).toStringAsFixed(2) ;
//     double taxable_amount = double.tryParse(taxable_amount_PriceControllers.text) ?? 0.0;
//     PriceVATControllers.text = (0.13*taxable_amount).toStringAsFixed(2);
//     double vat_amount = double.tryParse(PriceVATControllers.text) ?? 0.0;
//     totalAmountControllers.text = (vat_amount + taxable_amount).toStringAsFixed(2);
//
//     // taxable_amount_PriceControllers.text = totalPrice - double.tryParse(finalAmountControllers.text) ?? 0.0));
//
//     notifyListeners();
//
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "Stock Items": List.generate(invoiceItems.length, (index) => {
//         "H.S Code" : HSCodeControllers[index].text,
//         "Name": nameControllers[index].text,
//         "CP Rate": rateCPControllers[index].text,
//         "SP Rate": rateSPControllers[index].text,
//         "Unit": unitControllers[index].text,
//         "Quantity": quantityControllers[index].text,
//         "Cost Total": CPPriceControllers[index].text,
//         "Selling Total": SPPriceControllers[index].text,
//       }),
//       "Total Cost Price": totalCPPriceControllers.text,
//       "Total Selling Price": totalSPPriceControllers.text,
//       "Taxable Amount":taxable_amount_PriceControllers.text,
//       "VAT Amount": PriceVATControllers.text,
//       "Discount Percentage": discountControllers.text,
//       "Total Amount": totalAmountControllers.text,
//       "Remarks": RemarksController.text,
//
//       "From Name": From_Name.text,
//       "From PAN": From_PAN.text,
//       "Bill No": BillNo.text,
//
//
//       "Payment Paid":Paid,
//       "Date" :  NepaliDateFormat('yyyy-MM-dd').format(selectedDate)
//
//
//     };
//   }
//
//   bool isFormComplete() {
//     // Check if all invoice item fields are filled
//     for (int i = 0; i < invoiceItems.length; i++) {
//       if (HSCodeControllers[i].text.isEmpty ||
//           nameControllers[i].text.isEmpty ||
//           rateCPControllers[i].text.isEmpty ||
//           rateSPControllers[i].text.isEmpty ||
//           unitControllers[i].text.isEmpty ||
//           quantityControllers[i].text.isEmpty ||
//           CPPriceControllers[i].text.isEmpty ||
//           SPPriceControllers[i].text.isEmpty
//       ) {
//         return false;
//       }
//     }
//
//     // Check other required fields
//     final requiredFields = [
//       totalCPPriceControllers.text,
//       taxable_amount_PriceControllers.text,
//       PriceVATControllers.text,
//       discountControllers.text,
//       totalAmountControllers.text,
//       RemarksController.text,
//       From_Name.text,
//       From_PAN.text,
//     ];
//
//     for (final field in requiredFields) {
//       if (field.isEmpty) return false;
//     }
//
//     // Optionally, check date
//     if (selectedDate == null) return false;
//
//     return true;
//   }
//
//   Future <void> addStockPost() async{
//     final response = await http.post(
//         Uri.parse(url + "/create/stocks/"),
//         body: jsonEncode(toJson()),
//         headers: {
//           'Content-Type' : 'application/json',
//           'Authorization':'Bearer ${accessToken}'
//         }
//     );
//     // if(response.statusCode == 200){
//     //   removeRow();
//     // }
//     // print(jsonEncode(toJson()));
//     print(response.statusCode);
//     Map decoded_response = jsonDecode(response.body);
//     print(decoded_response["message"]);
//   }
//
//   late Map<String, dynamic> decoded_response = {};
//   bool filtermenu = false;
//
//
//   void filtermenuchange(){
//     filtermenu = !filtermenu;
//     notifyListeners();
//   }
//
//
//   Future <void> getStocks() async{
//     final response = await http.get(
//         Uri.parse(url+"/stocks/"),
//         headers : {
//           'Content-Type' : 'application/json',
//           'Authorization':'Bearer ${accessToken}'
//         }
//     );
//
//     if(response.statusCode == 200) {
//       decoded_response = jsonDecode(response.body);
//       // print(decoded_response);
//       notifyListeners();
//     }
//
//   }
//
//   void updateSelectedName(String name, int index) {
//     selectedName = name;
//
//     notifyListeners();
//   }
//
//
//
//
// }


class   Data extends ChangeNotifier{
  late String Company_Type="";
  late String Company="";
  late String PAN = "";
  late String username = "";
  String? access_token = accessToken;
  late Map decodedResponse ={};
  void get_data()async{
    final response = await http.get(
      Uri.parse(url+"/data/general/"),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer ${accessToken}'
      },
    );
    if(response.statusCode == 200){
      decodedResponse = jsonDecode(response.body);
      Company_Type = decodedResponse["Company Type"];
      Company = decodedResponse["Company"];
      PAN = decodedResponse["PAN No"].toString();
      username = decodedResponse["username"].toString();
      // print(decoded_response["Company"]);
    }
    else{

    }

  }
}

class SettingsProvider extends ChangeNotifier{
  String? fileName;
  Uint8List? bytes;
  int? responseCode;
  TextEditingController startingInvoiceNumber = TextEditingController();

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
      withData: true,
    );

    if (result != null) {
      fileName = result.files.single.name;

      final file = result.files.single;
      bytes =file.bytes;
    }
    else{
      // print(null);
    }
    notifyListeners();
  }

  Future <void> sendRequest() async{
    print("request going");
    final request = http.MultipartRequest('POST', Uri.parse(url+'setting/bill'));
    request.headers.addAll({
      'Authorization': 'Bearer ${accessToken}',
    });

    request.files.add(http.MultipartFile.fromBytes('png', bytes!, filename: fileName));
    final response = await request.send();
    responseCode = response.statusCode;
    if(response.statusCode==200){
      print("done");

    }
    else{
      print("problem");
    }
    notifyListeners();
  }

  Future<void> InvoiceStartingRequest() async{
    final data = {
      "Starting Invoice" : startingInvoiceNumber.text
    };
    final response = await http.post(
        Uri.parse(url+"/create/employeelogs/"),
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer ${accessToken}'
        },
        body: jsonEncode(data)
    );
  }


  void openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class EmployeesProvider extends ChangeNotifier{
  bool add_employee_space = false;
  TextEditingController name = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController contact = TextEditingController();
  List<dynamic> decoded_response = [];
  List<dynamic> decoded_response_logs = [];


  void toggle_employee_space(){
    add_employee_space = !add_employee_space;
    notifyListeners();
  }

  Future <void> addEmployee() async{
    final nepaliDate = DateTime.now().toNepaliDateTime(); // already local
    // final nepaliDate = NepaliDateTime.fromDateTime(now);
    // final dateOnly = NepaliDateTime(nepaliDate.year, nepaliDate.month, nepaliDate.day );
    final data = {
      "name": name.text,
      "position":position.text,
      "monthlySalary":salary.text,
      "contact":contact.text,
      "lastUpdated": NepaliDateFormat('yyyy-MM-dd').format(nepaliDate),
      "joinedDate": NepaliDateFormat('yyyy-MM-dd').format(nepaliDate),
    };
    final response = await http.post(
      Uri.parse(url+"/create/employees/"),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer ${accessToken}'
      },
      body: jsonEncode(data)
    );
    print(response.statusCode);
    notifyListeners();
  }

  Future <void> getEmployee()async{
    final response= await http.get(
      Uri.parse(url+'/employees/'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer ${accessToken}'
      },
    );
    print("got request");

    if(response.statusCode == 200) {
      decoded_response = jsonDecode(response.body);
      print(decoded_response);
    }
    notifyListeners();
  }
  Future <void> getEmployeelogs(int id)async{
    final response= await http.get(
      Uri.parse(url+'/employee/logs/${id}/'),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer ${accessToken}'
      },
    );
    print("got request");
    print(response.statusCode);
    if(response.statusCode == 200) {
      decoded_response_logs = jsonDecode(response.body);
      print(decoded_response_logs);
    }
    notifyListeners();
  }

  TextEditingController amount = TextEditingController();
  TextEditingController reason = TextEditingController();

  TextEditingController dateController = TextEditingController(text: NepaliDateFormat('yyyy-MM-dd').format(DateTime.now().toNepaliDateTime()).toString());
  Future<void> postLog(int id) async{
    final data = {
      "amount": amount.text,
      "reason":reason.text,
      "date": dateController.text,
      "id": id
    };
    final response = await http.post(
        Uri.parse(url+"/create/employeelogs/"),
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer ${accessToken}'
        },
        body: jsonEncode(data)
    );
    print(response.statusCode);
    // print(data);
    notifyListeners();
  }

}