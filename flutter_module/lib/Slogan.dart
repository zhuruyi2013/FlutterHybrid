import 'package:flutter/material.dart';

class Slogan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//      access android assets dir image
//      AssetManager assetManager = registrar.context().getAssets();
//      String key = registrar.lookupKeyForAsset("icons/heart.png");
//      AssetFileDescriptor fd = assetManager.openFd(key);
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 24.0),
        child: Center(
            child: Image.asset('images/ic_bottom_logo.png', fit: BoxFit.scaleDown,),
        )
    );
  }
}
