import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:recordex/Hive/hive_main.dart';
import '../HomePage/color.dart';
import 'package:http/http.dart' as http;

String url = "http://127.0.0.1:8000";


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
  String? selectedName = null;

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
  TextEditingController To_Name = TextEditingController();
  TextEditingController To_PAN = TextEditingController();
  NepaliDateTime selectedDate = NepaliDateTime.now();

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
  TextEditingController RemarksController = TextEditingController();

  void addRow() {
    invoiceItems.add({"hs": "","name": "","unitPrice": "","unit" : "", "quantity": "",  "totalPrice": ""});
    HSCodeControllers.add(TextEditingController(text: "-"));
    nameControllers.add(TextEditingController());
    quantityControllers.add(TextEditingController());
    rateControllers.add(TextEditingController());
    unitControllers.add(TextEditingController());
    amountPriceControllers.add(TextEditingController());
    notifyListeners();
  }

  void removeRow(int index) {
    invoiceItems.removeAt(index);
    nameControllers[index].dispose();
    HSCodeControllers[index].dispose();
    quantityControllers[index].dispose();
    rateControllers[index].dispose();
    unitControllers[index].dispose();
    amountPriceControllers[index].dispose();

    HSCodeControllers.removeAt(index);
    nameControllers.removeAt(index);
    quantityControllers.removeAt(index);
    rateControllers.removeAt(index);
    unitControllers.removeAt(index);
    amountPriceControllers.removeAt(index);


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

      "From Name": From_Name.text,
      "From PAN": From_PAN.text,

      "To Name": To_Name.text,
      "To PAN" : To_PAN.text,

      "Date" :  NepaliDateFormat('yyyy-MM-dd').format(selectedDate)


    };
  }

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
    print(jsonEncode(toJson()));
    print(response.statusCode);
  }

}





class Login_Provider extends ChangeNotifier{
  TextEditingController username= TextEditingController();
  TextEditingController password= TextEditingController();

  int response_code = 0;
  late String? error_msg = null;
  late Map<String, dynamic> decoded_response;
  late bool? loggedin=null;

  void login(TextEditingController username,TextEditingController password)async{
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

  }
}

class CheckToken extends ChangeNotifier{
  late bool? is_valid = null;

  Future <void> check() async{
    final tokens = await getAuthTokens();
    final accessToken = tokens['accessToken'];
    print("Code has been executed");

    final response = await http.get(
      Uri.parse(url+"/checktoken/"),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer ${accessToken}'
      },
    );
    if(response.statusCode == 200){
      is_valid = true;
    }
    else{
      is_valid = false;
    }
    notifyListeners();
  }

}