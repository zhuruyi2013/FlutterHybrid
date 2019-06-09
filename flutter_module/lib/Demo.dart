import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'PlatformHelper.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlatformHelper().initNativeHandler();

    return MaterialApp(
      title: "demo",
      home: Scaffold(
        appBar: AppBar(
          title: Text("demo"),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  PlatformHelper().requestAdd((result){
                    Toast.show("result from native = $result", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  });
                },
                child: Text("call android add"),
              )
            ],
          ),
        ),
      ),
    );
  }

}
