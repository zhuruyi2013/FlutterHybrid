package com.zry.flutterhybrid

import android.os.Bundle
import android.os.CountDownTimer
import android.support.v7.app.AppCompatActivity
import android.util.Log
import io.flutter.facade.Flutter
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val flutterView = Flutter.createView(this, lifecycle, "/setting")
        setContentView(flutterView)


        MethodChannel(flutterView, FLUTTER_CHANNEL_NAME).setMethodCallHandler { call, result ->
            if (call.method == "add") {
                Log.d("111", "enter test")
                try {
                    val a = call.argument<Int>("a")
                    val b = call.argument<Int>("b")
                    Log.d("111", "a=$a , b=$b")

                    val res = doRealAdd(a, b)
                    result.success(res)
                } catch (e: ClassCastException) {
                    e.printStackTrace()
                }
            } else {
                result.notImplemented()
            }
        }

        nativeSendFlutter(flutterView, EVENT_CHANNEL_NAME)
    }

    private fun doRealAdd(a: Int, b: Int): Int {
        return a + b
    }

    private fun nativeSendFlutter(messenger: BinaryMessenger, name : String) {
        EventChannel(messenger, name).setStreamHandler(
            object : EventChannel.StreamHandler{
                override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
                    val timer = object : CountDownTimer(10* 1000, 1000){
                        /**
                         * Callback fired when the time is up.
                         */
                        override fun onFinish() {

                        }

                        override fun onTick(millisUntilFinished: Long) {
                            p1?.success("time=$millisUntilFinished")
                        }
                    }
                    timer.start()
                }

                override fun onCancel(p0: Any?) {

                }
            }
        )
    }
}

private const val FLUTTER_CHANNEL_NAME = "com.dadaabc.zhuozan/hybrid"

private const val EVENT_CHANNEL_NAME = "com.dadaabc.eventchannel/stream"
