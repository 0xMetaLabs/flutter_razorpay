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
  private Result pendingResult;
    private Map<String, Object> arguments;
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
    pendingResult=result;
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("RazorPayWindow")) {
      arguments = (Map<String, Object>) call.arguments;
      Intent razorpayIntent = new Intent(activity, RazorpayActivity.class);
      razorpayIntent.putExtra(RazorpayActivity.EXTRA_PRODUCT_NAME, (String) arguments.get("name"));
      razorpayIntent.putExtra(RazorpayActivity.EXTRA_PRODUCT_IMAGE, (String) arguments.get("image"));
      razorpayIntent.putExtra(RazorpayActivity.EXTRA_PRODUCT_DESCRIPTION, (String) arguments.get("description"));
      razorpayIntent.putExtra(RazorpayActivity.EXTRA_PRODUCT_AMOUNT, (String) arguments.get("amount"));
      razorpayIntent.putExtra(RazorpayActivity.EXTRA_PREFILL_EMAIL, (String) arguments.get("email"));
      razorpayIntent.putExtra(RazorpayActivity.EXTRA_PREFILL_CONTACT, (String) arguments.get("contact"));
      razorpayIntent.putExtra(RazorpayActivity.RAZORPAY_KEY, (String) arguments.get("razorpay_key"));
      activity.startActivityForResult(razorpayIntent, 111);
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
              String response=intent.getStringExtra("payment_id");
              data.add("1");
              data.add(response);
              pendingResult.success(data);
          }
          else
          {
              List<String> data=new ArrayList<>();
              String response=intent.getStringExtra("payment_id");
              data.add("0");
              data.add(response);
              pendingResult.success(data);
          }
          pendingResult = null;
          arguments = null;
          return true;
      }
        return false;
    }
}
