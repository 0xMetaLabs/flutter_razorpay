package com.cueclad.flutterrazorpay;

import android.app.Activity;
import android.content.Intent;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterRazorpayPlugin */
public class FlutterRazorpayPlugin implements MethodCallHandler,PluginRegistry.ActivityResultListener {
  private final MethodChannel channel;
  private Activity activity;
    Result pendingResult;
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_razorpay");
      FlutterRazorpayPlugin instance=new FlutterRazorpayPlugin(registrar.activity(),channel);
    channel.setMethodCallHandler(instance);
    registrar.addActivityResultListener(instance);
  }
  private FlutterRazorpayPlugin(Activity activity,MethodChannel channel)
  {
    this.activity=activity;
    this.channel=channel;
    this.channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("RazorPayWindow")) {
      String msg = call.argument("msg").toString();
      Intent playerIntent = new Intent(activity, RazorpayActivity.class);
      activity.startActivityForResult(playerIntent, 111);
    }
    else {
      result.notImplemented();
    }
  }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {
      if (requestCode==111)
      {
          if (resultCode==Activity.RESULT_OK)
          {
              List<String> data=new ArrayList<>();
              String response=intent.getStringExtra("paymentId");
              data.add("1");
              data.add(response);
              pendingResult.success(response);
          }
          else
          {
              List<String> data=new ArrayList<>();
              String response=intent.getStringExtra("paymentId");
              data.add("0");
              data.add(response);
              pendingResult.success(response);
          }
      }
        return false;
    }
}
