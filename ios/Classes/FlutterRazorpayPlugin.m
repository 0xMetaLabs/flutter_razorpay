#import "FlutterRazorpayPlugin.h"
#import <flutter_razorpay/flutter_razorpay-Swift.h>

@implementation FlutterRazorpayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterRazorpayPlugin registerWithRegistrar:registrar];
}
@end
