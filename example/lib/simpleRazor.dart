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
      appBar: new AppBar(title: new Text("Hey Razer Pay"),),
      body: new RaisedButton(onPressed: (){
        _simpleMethod();
      },
        child: new Text("Click here",style: new TextStyle(fontSize: 20.0),),
      ),

    );
  }
  _simpleMethod() async
  {
    await FlutterRazorpay.getRazorPayWindow("Hey got it");
  }
}
