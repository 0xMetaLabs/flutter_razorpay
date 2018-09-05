import 'dart:async';

import 'package:flutter/services.dart';

class FlutterRazorpay {
  static const MethodChannel _channel =
      const MethodChannel('flutter_razorpay');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Null> getRazorPayWindow(String msg) async {
    Map<String,dynamic> map= <String,dynamic>{};
    map.putIfAbsent("msg",()=> msg);
    await _channel.invokeMethod('RazorPayWindow',map);
    return null;
  }
}
