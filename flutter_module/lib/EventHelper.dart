import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class EventHelper {
	static const stream = const EventChannel('com.dadaabc.eventchannel/stream');

	static final EventHelper _singleton = new EventHelper._internal();

	factory EventHelper() {
		return _singleton;
	}

	EventHelper._internal();

	StreamSubscription _timerSubscription;

	void enableListen(Function func) {
		this.func = func;

		if (_timerSubscription == null) {
			_timerSubscription = stream.receiveBroadcastStream().listen(_update); // 添加监听
		}
	}

	void disableListen() {
		if (_timerSubscription != null) {
			_timerSubscription.cancel();
			_timerSubscription = null;
		}
	}

	void _update(timer) {
		debugPrint("Timer $timer");
		func(timer);
	}

	Function func;
}

typedef VoidCallback = void Function();
