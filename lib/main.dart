import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/home/home.dart';
import 'package:flutter_demo/home/login.dart';

void main() {
//  debugPaintSizeEnabled = true;
  ///捕获全局异常
  runZoned(() => runApp(new MyApp()), onError: (object, stackTrace) {
    print("object ：$object ----->>>>  stackTrace: $stackTrace");
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        platform: TargetPlatform.iOS,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
//        primarySwatch: Colors.blue,
//        primaryColor: Colors.black38
      ),
      home: new MyHomePage(title: 'Chart'),
      onGenerateTitle: (BuildContext context) {
        return "头部";
      },
      routes: <String, WidgetBuilder>{
        "login": (BuildContext context) => LoginActivity(),
      },
    );
  }
}
