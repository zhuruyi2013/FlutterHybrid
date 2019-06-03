import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PlatformHelper {
	static const platform = MethodChannel("com.dadaabc.zhuozan/hybrid");


	String MNAME_TEST = "add";

	static final PlatformHelper _singleton = new PlatformHelper._internal();

	factory PlatformHelper() {
		return _singleton;
	}

	PlatformHelper._internal();


	Future<void> requestAdd() async {
		try {
			final int result = await platform.invokeMethod(MNAME_TEST,
				<String, dynamic>{
			         'a': 20,
			         'b': 30,
			       });
			debugPrint('result add = $result .');
		} on PlatformException catch (e) {
			debugPrint("Failed to get battery level: '${e.message}'.");
		}

	}
}
