import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recordex/Authentication/login.dart';
import 'package:recordex/Provider/color_provider.dart';
import 'package:recordex/Provider/main_provider.dart';

import 'package:window_manager/window_manager.dart';
import 'homepage.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(1250,800),
    size: Size(1250, 800,),
    center: true,
    backgroundColor: Colors.transparent,
    title: "Recordex",
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,


  );
  await windowManager.waitUntilReadyToShow(windowOptions,() async {
    await windowManager.show();
    await windowManager.focus();
    // await windowManager.setMovable(true);

  });
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => General()),
        ChangeNotifierProvider(create: (context) => AppColors()),
        ChangeNotifierProvider(create: (context) => InvoicePayment()),
        ChangeNotifierProvider(create: (_) => Login_Provider()),

      ],
      child:Homepage()
  )
  );
}

