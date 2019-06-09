package com.zry.flutterhybrid

import android.os.Bundle
import android.os.CountDownTimer
import android.support.v7.app.AppCompatActivity
import android.util.Log
import io.flutter.facade.Flutter
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    lateinit var methodChannel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        val flutterView = Flutter.createView(this, lifecycle, "demo")
        flutterContainer.addView(flutterView)

        methodChannel = MethodChannel(flutterView, FLUTTER_CHANNEL_NAME)

        //这里是native调用dart函数
        callDartMethod.setOnClickListener {
            //第二个参数可以约定json，这里为了简化使用了简单的字符串
            methodChannel.invokeMethod("flutter_add", "a=20;b=30", object : MethodChannel.Result{
                override fun notImplemented() {
                }

                override fun error(p0: String?, p1: String?, p2: Any?) {
                    showResult("receive dart error = $p0")
                }

                override fun success(p0: Any?) {
                    showResult("receive dart result = $p0")
                }
            })
        }



        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "add") {
                Log.d("111", "enter test")
                try {
                    val a = call.argument<Int>("a")
                    val b = call.argument<Int>("b")
                    Log.d("111", "a=$a , b=$b")

                    val res = doRealAdd(a!!, b!!)
                    result.success(res)
                } catch (e: ClassCastException) {
                    e.printStackTrace()
                }
            } else {
                result.notImplemented()
            }
        }

        nativeSendFlutterWithEventChannel(flutterView, EVENT_CHANNEL_NAME)
    }

    private fun doRealAdd(a: Int, b: Int): Int {
        return a + b
    }

    private fun nativeSendFlutterWithEventChannel(messenger: BinaryMessenger, name: String) {
        EventChannel(messenger, name).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
                        val timer = object : CountDownTimer(10 * 1000, 1000) {
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

    fun showResult(result:String){
       runOnUiThread {
           showResultTv.text = result;
       }
    }
}

private const val FLUTTER_CHANNEL_NAME = "com.dadaabc.zhuozan/hybrid"

private const val EVENT_CHANNEL_NAME = "com.dadaabc.eventchannel/stream"
