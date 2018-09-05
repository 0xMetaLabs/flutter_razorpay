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
        title: new Text("Hey Razer Pay"),
      ),
      body: new RaisedButton(
        onPressed: () {
          _simpleMethod();
        },
        child: new Text(
          "Click here",
          style: new TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  _simpleMethod() async {
    Map<String,dynamic> map=new Map();
     map.putIfAbsent("name",()=> "SunBurn");
     map.putIfAbsent("image",()=> "https://firebasestorage.googleapis.com/v0/b/cueclad.appspot.com/o/user_banner.jpg?alt=media&token=2573692d-b182-4261-9f35-3f378428f55d");
    map.putIfAbsent("description",()=> "Amazing Performance by Something");
    map.putIfAbsent("amount",()=> "100");
    map.putIfAbsent("email",()=> "test@razorpay.com");
    map.putIfAbsent("contact",()=> "9876543210");
    List<dynamic> data = new List();
    data = await FlutterRazorpay.getRazorPayWindow(map);
    print("Damn *************** $data");
  }
}
