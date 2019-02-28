
import 'package:flutter/services.dart';

class BatteryLev<T>{

  MethodChannel methodChannel = const MethodChannel('samples.flutter.io/battery');

  static BatteryLev batteryLev = BatteryLev();

  Future<T> getPlatformVersion<T>([ dynamic arguments ]){
    return methodChannel.invokeMethod("getBatteryLevel",arguments);
  }


}