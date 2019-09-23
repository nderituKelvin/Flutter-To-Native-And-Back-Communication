package ke.co.kelvinnderitu.native_to_dart_message

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

internal class MainActivity : FlutterActivity() {
    public override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        methodChannel = MethodChannel(flutterView, CHANNEL)
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { methodCall, result ->
            if (methodCall.method == "helloFromNativeCode") {
                methodChannel.invokeMethod("helloFromJava", "Hello From Java")
                result.success("Kelvin Nderitu")
            } else {
                result.success("Not Kelvin")
            }

        }
    }

    companion object {
        private val CHANNEL = "flutter.native/helper"
        lateinit var methodChannel: MethodChannel
    }
}
