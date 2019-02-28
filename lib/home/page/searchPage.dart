import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage>{

  static const platform = const MethodChannel('samples.flutter.io/battery');

  static const platformDemo = const MethodChannel('flutter_batterylevl');

  String _batteryLevel = 'Unknown battery level.';

  Future<dynamic> platformCallHandler(MethodCall call) async {
    var method = call.method;
    print("调用组件方法 $method");
    switch (call.method) {
      case "getName":
        return "Hello from Flutter";
        break;
    }
  }

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      final resultPlugin = await platformDemo.invokeMethod("getPlatformVersion");
      batteryLevel = 'Battery level at $result % .$resultPlugin';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    platform.setMethodCallHandler(platformCallHandler);

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索"),
      ),
     body: Text("电池电量：$_batteryLevel" ),
    );
  }

}