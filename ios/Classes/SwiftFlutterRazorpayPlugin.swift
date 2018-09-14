import Flutter
import UIKit
import Razorpay

    
public class SwiftFlutterRazorpayPlugin: NSObject, FlutterPlugin, RazorpayPaymentCompletionProtocol {
    var razorpay: Razorpay!
    var _result: FlutterResult!
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_razorpay", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterRazorpayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

  _result=result
   if(call.method.elementsEqual("RazorPayWindow"))
    {
        let argue = call.arguments as? NSDictionary
        let product_name = argue!["name"] as? String
        let product_des = argue!["description"] as? String
        let product_image = argue!["image"] as? String
        let product_amount = argue!["amount"] as? String
        let product_email = argue!["email"] as? String
        let product_contact = argue!["contact"] as? String
        let API_KEY = argue!["razorpay_key"] as? String
        razorpay=Razorpay.initWithKey(API_KEY!, andDelegate: self )
        showPaymentForm(name: product_name!, des:product_des!, image:product_image!, amount:product_amount!,email:product_email!, contact:product_contact!);
    }
    else {
          result("iOS " + UIDevice.current.systemVersion)
    }
    
  
  }
 public func showPaymentForm(name:String,des:String,image:String,amount:String,email:String,contact:String)
      {
           NSLog("Hello ^^^^^^^^^^^^^^^")
          let params: [String:Any] =
          [
              "name": name,
              "description": des,
              "image": image,
              "amount": amount,
              "prefill":[
                  "contact": contact,
                  "email": email,
              ],
              "theme":[
                  "color":"#28282d"
              ],
          ]
           NSLog("param ^^^^^^^^^^^^^^^")
           NSLog("%@",params)
           razorpay.open(params)
      }
  public func onPaymentError(_ code: Int32, description str: String) 
      {
          NSLog("onPaymentError ^^^^^^^^^^^^^^^")
          NSLog(str)
          var responseArray = [String]()
          responseArray.insert("0", at: 0)
          responseArray.insert(str, at: 1)
          NSLog("%@",responseArray)
          _result(responseArray)
      }

  public func onPaymentSuccess(_ payment_id: String) 
          {
          NSLog("onPaymentSuccess ^^^^^^^^^^^^^^^")
          var responseArray = [String]()
          responseArray.insert("1", at: 0)
          responseArray.insert(payment_id, at: 1)
          _result(responseArray)
          }
}
