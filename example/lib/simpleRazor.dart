import 'package:flutter/material.dart';
import 'package:flutter_razorpay/flutter_razorpay.dart';

class SimpleRazor extends StatefulWidget {
  @override
  _SimpleRazorState createState() => _SimpleRazorState();
}

class _SimpleRazorState extends State<SimpleRazor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Razer Pay"),
      ),
      body: new RaisedButton(
        onPressed: () {
          razorpay_payment();
        },
        child: new Text(
          "Pay",
          style: new TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  razorpay_payment() async {
    Map<String,dynamic> map=new Map();
      //// product name
      map.putIfAbsent("name",()=> "");
      //// product image
      map.putIfAbsent("image",()=>  "");
      //// product description
      map.putIfAbsent("description",()=> "");
      //// product amount note: 100 = 1 rupee .
      map.putIfAbsent("amount",()=> "");
      //// email id
      map.putIfAbsent("email",()=> "");
      //// contact number
      map.putIfAbsent("contact",()=> "");
      //// razorpay_key of testing/production
      map.putIfAbsent("razorpay_key",()=> "");
    List<dynamic> razor_pay_response = new List();

    razor_pay_response = await FlutterRazorpay.getRazorPayWindow(map);
    print("response *************** $razor_pay_response");
  }
}
