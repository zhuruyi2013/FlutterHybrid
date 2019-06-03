import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'Slogan.dart';
import 'PlatformHelper.dart';

class Setting extends StatefulWidget {
  bool isLogin = false;

  Setting(this.isLogin);

  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<Setting> {
  bool notifyIsOn = true;

  final double _ITEM_HEIGHT = 52.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "设置",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _divideSpace(context),
            widget.isLogin ? _settingItem("切换账号", "", true) : _empty(),
            widget.isLogin ? _divideLine(context) : _empty(),
            widget.isLogin ? _settingItem("修改密码", "", true) : _empty(),
            widget.isLogin ? _divideLine(context) : _empty(),
            widget.isLogin ? _settingItem("推送通知", "", false) : _empty(),
            widget.isLogin ? _divideLine(context) : _empty(),
            _settingItem("多语言", "", true),
            _divideSpace(context),
            _settingItem("清除缓存", "0KB", true),
            _divideLine(context),
            _settingItem("关于我们", "", true),
            _divideSpace(context),
            widget.isLogin ? _exit() : _empty(),
            Slogan(),
          ],
        ),
      ),
    );
  }

  Widget _empty() {
    return Container();
  }

  Widget _exit() {
    return Container(
      height: _ITEM_HEIGHT,
      child: Container(
        color: Colors.white,
        child: Center(
          child: FlatButton(
              onPressed: _onExitClick,
              child: Text(
                "退出当前账号",
                style: TextStyle(color: Colors.red, fontSize: 16.0),
              )),
        ),
      ),
    );
  }

  Widget _divideSpace(BuildContext context) {
    return Container(
      height: 10.0,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _divideLine(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      height: 1.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
    );
  }

  Widget _settingItem(String title, String description, bool isRightArror) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      height: _ITEM_HEIGHT,
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 15.0, color: Colors.black),
            ),
          ),
          (description == "" || description == null)
              ? Text(description, style: TextStyle(fontSize: 15.0))
              : Container(),
          isRightArror
              ? Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16.0,
                )
              : Switch(
                  value: notifyIsOn,
                  onChanged: _onNotifyChange,
                  activeColor: Colors.red,
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.grey,
                )
        ],
      ),
    );
  }

  void _onNotifyChange(bool change) {
    setState(() {
      notifyIsOn = change;
    });

    if (notifyIsOn) {
      debugPrint("will call notifyIsOn");
    } else {
      debugPrint("will call notifyIsOff");
    }
  }

  void _onExitClick() {
    debugPrint("Exit");
    PlatformHelper().requestAdd();
  }
}
