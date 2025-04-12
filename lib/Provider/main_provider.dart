import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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




  List<Map<String, dynamic>> invoiceItems = [];
  List<TextEditingController> HSCodeControllers = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> quantityControllers = [];
  List<TextEditingController> unitPriceControllers = [];
  List<TextEditingController> totalPriceControllers = [];
  TextEditingController grandPriceControllers = TextEditingController();
  TextEditingController totalPriceVATControllers = TextEditingController();
  TextEditingController discountControllers = TextEditingController(text: "0");
  TextEditingController finalAmountControllers = TextEditingController();

  void addRow() {
    invoiceItems.add({"name": "", "quantity": "", "unitPrice": "", "totalPrice": ""});
    HSCodeControllers.add(TextEditingController(text: "-"));
    nameControllers.add(TextEditingController());
    quantityControllers.add(TextEditingController());
    unitPriceControllers.add(TextEditingController());
    totalPriceControllers.add(TextEditingController());
    notifyListeners();
  }

  void removeRow(int index) {
    invoiceItems.removeAt(index);
    nameControllers[index].dispose();
    HSCodeControllers[index].dispose();
    quantityControllers[index].dispose();
    unitPriceControllers[index].dispose();
    totalPriceControllers[index].dispose();

    HSCodeControllers.removeAt(index);
    nameControllers.removeAt(index);
    quantityControllers.removeAt(index);
    unitPriceControllers.removeAt(index);
    totalPriceControllers.removeAt(index);


    grandTotal();
    discountPercentage();
    // notifyListeners();
  }

  // Calculate the total price for a row
  void calculateTotalPrice(int index) {
    double quantity = double.tryParse(quantityControllers[index].text) ?? 0;
    double unitPrice = double.tryParse(unitPriceControllers[index].text) ?? 0;
    double totalPrice = quantity * unitPrice;
    totalPriceControllers[index].text = totalPrice.toStringAsFixed(2);
    grandTotal();
    discountPercentage();
  }


  void grandTotal() {
    double total = 0.0;
    for (var controller in totalPriceControllers) {
      double value = double.tryParse(controller.text) ?? 0.0;
      total += value;
    }
    grandPriceControllers.text = total.toStringAsFixed(2);
    totalPriceVATControllers.text = (total + 0.13*total).toStringAsFixed(2);
    notifyListeners();
  }


  void discountPercentage(){
    double totalPriceVAT = double.tryParse(totalPriceVATControllers.text) ?? 0.0;
    double discountPer = double.tryParse(discountControllers.text) ?? 0.0;


    finalAmountControllers.text = (totalPriceVAT-0.01*discountPer*totalPriceVAT).toStringAsFixed(2) ;

    notifyListeners();

  }

  Map<String, dynamic> toJson() {
    return {
      "invoiceItems": List.generate(invoiceItems.length, (index) => {
        "H.S Code" : HSCodeControllers[index].text,
        "name": nameControllers[index].text,
        "quantity": quantityControllers[index].text,
        "unitPrice": unitPriceControllers[index].text,
        "totalPrice": totalPriceControllers[index].text,
      }),
      "grandTotal": grandPriceControllers.text,
      "totalPriceVAT": totalPriceVATControllers.text,
      "discount": discountControllers.text,
      "finalAmount": finalAmountControllers.text,
    };
  }


}





class Login_Provider extends ChangeNotifier{
  TextEditingController username= TextEditingController();
  TextEditingController password= TextEditingController();

  int response_code = 0;


  void login(TextEditingController username,TextEditingController password)async{
    String username_text = username.text;
    String password_text = password.text;


    dynamic request = {
      "username": username_text,
      "password": password_text
    };
    final response = await http.post(
      Uri.parse(url + "/login/"),
      body: jsonEncode(request),
      headers: {
        'Content-Type': 'application/json',
        // Add any additional headers if needed
      },
    );
    response_code = response.statusCode;
    print(response_code);
    notifyListeners();

  }
}