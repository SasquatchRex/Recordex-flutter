import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recordex/Processing/Provider/main_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'homepage.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await Hive.initFlutter();
  await WidgetsFlutterBinding.ensureInitialized();


  final tokenProviderAPP = CheckToken();
  await tokenProviderAPP.check();

  // WindowOptions windowOptions = const WindowOptions(
  //   minimumSize: Size(1250,800),
  //   size: Size(1250, 800,),
  //   center: true,
  //   backgroundColor: Colors.transparent,
  //   title: "Recordex",
  //   titleBarStyle: TitleBarStyle.normal,
  //   windowButtonVisibility: true,
  // );
  // appWindow.show();




  // await windowManager.waitUntilReadyToShow(windowOptions,() async {
  //   await windowManager.show();
  //   await windowManager.focus();
  //   // await windowManager.setMovable(true);
  //
  // });
  WidgetsFlutterBinding.ensureInitialized();


  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => General()),
        ChangeNotifierProvider(create: (context) => AppColors()),
        ChangeNotifierProvider(create: (context) => InvoicePayment()),
        ChangeNotifierProvider(create: (context) => InvoicePaymentShop()),
        ChangeNotifierProvider(create: (_) => Login_Provider()),
        ChangeNotifierProvider(create: (_) => CheckToken()),
        ChangeNotifierProvider(create: (_) => invoiceManagementProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseManagementProvider()),
        ChangeNotifierProvider(create: (_) => Data()),
        ChangeNotifierProvider(create: (_) => Stocks()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => EmployeesProvider()),

      ],
      child:Homepage()
  )
  );
  doWhenWindowReady(() {
    const initialSize = Size(1250, 800);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Recordex";

    appWindow.show();
  });


}

