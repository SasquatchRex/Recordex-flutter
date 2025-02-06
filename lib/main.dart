import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'HomePage/homepage.dart';




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
  runApp( Homepage());
}