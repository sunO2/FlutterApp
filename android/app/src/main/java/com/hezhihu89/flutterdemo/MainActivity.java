package com.hezhihu89.flutterdemo;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String TAG = MainActivity.class.getSimpleName() + ": HEZHIHU89";

  private static final String CHANNEL = "samples.flutter.io/battery";


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    // 直接 new MethodChannel，然后设置一个Callback来处理Flutter端调用
    MethodChannel channel = new MethodChannel(getFlutterView(), CHANNEL);

    channel.setMethodCallHandler((call, result) ->{
      if (call.method.equals("getBatteryLevel")) {
        int batteryLevel = getBatteryLevel();

        if (batteryLevel != -1) {
          result.success(batteryLevel);
          Log.d(TAG,"success 获取成功");
        } else {
          result.error("UNAVAILABLE", "Battery level not available.", null);
          Log.d(TAG,"error 获取失败");
        }
      } else {
        result.notImplemented();
        Log.d(TAG,"notImplemented 没有实现");
      }

      channel.invokeMethod("getName", "", new MethodChannel.Result() {
        @Override
        public void success(Object o) {
          Log.d(TAG,"success 获取成功" + o);
        }

        @Override
        public void error(String s, String s1, Object o) {
          Log.d(TAG,"error 获取失败 o: " + o + "；s ：" + s + "; s1: " + s1);
        }

        @Override
        public void notImplemented() {
          Log.d(TAG,"notImplemented 没有方法");
        }
      });
    });



  }

  private int getBatteryLevel() {
    int batteryLevel = -1;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      if(null != batteryManager) {
        batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
      }
    } else {
      Intent intent = new ContextWrapper(getApplicationContext()).
              registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      if(null != intent) {
        batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
      }
    }

    return batteryLevel;
  }
}



















