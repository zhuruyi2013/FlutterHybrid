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

	void initNativeHandler(){
		platform.setMethodCallHandler((methodCall){
			print("receive native call , methodCall.method = ${methodCall.method}");
			if(methodCall.method == "flutter_add") {
				//此处简化了传参，可以优化使用json， 这里是a=30;b=20的形式
				try {
					String argument = methodCall.arguments;
					var arr = argument.split(";");
					arr.forEach((str){
						print("dart add str = $str  ");
					});
					int result = int.parse(arr[0].split("=")[1]) + int.parse(arr[1].split("=")[1]);
					print("dart add result = $result");
					return Future<String>((){
						return result.toString();
					});
				} catch (e) {
					return Future((){
						return PlatformException(code: 'add err');
					});
				}

			}
		});
	}


	Future<void> requestAdd(callback) async {
		try {
			final int result = await platform.invokeMethod(MNAME_TEST,
				<String, dynamic>{
			         'a': 20,
			         'b': 30,
			       });
			debugPrint('result add = $result .');
			callback(result);
		} on PlatformException catch (e) {
			debugPrint("Failed to get result: '${e.message}'.");
		}

	}
}
