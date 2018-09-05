import 'dart:async';

import 'package:flutter/services.dart';

class FlutterRazorpay {
  static const MethodChannel _channel =
      const MethodChannel('flutter_razorpay');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List<dynamic>> getRazorPayWindow(Map<String,dynamic> map) async {
    List<dynamic> data=new List();
    data=await _channel.invokeMethod('RazorPayWindow',map);
    return data;
  }
}
