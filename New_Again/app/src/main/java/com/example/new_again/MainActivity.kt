package com.example.new_again
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        

        findViewById<Button>(R.id.firstModuleButton).setOnClickListener {
            setFlutterEngine("firstModule")

        }
        findViewById<Button>(R.id.secondModuleButton).setOnClickListener {
            setFlutterEngine("secondModule")
        }
    }

    private fun setFlutterEngine(entryMethod:String?){
        val token = "this_is_from_Android_App_native"
        val channel = "com.example.flutter_module"
        val flutterEngineID = "module_flutter_engine"

        val flutterEngine = FlutterEngine(/* context = */ this).also {
            it.navigationChannel.setInitialRoute("/$entryMethod")
            it.dartExecutor.executeDartEntrypoint(
                DartEntrypoint.createDefault()
            )
//            it.dartExecutor.executeDartEntrypoint(
//                DartEntrypoint(
//                    it.dartExecutor.binaryMessenger.toString(),
//                    entryMethod?:"main"
//                )
//            )
        }
        FlutterEngineCache
            .getInstance()
            .put(flutterEngineID, flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (call.method == "nativeMethod") {
                    result.success(token)
                } else {
                    result.notImplemented()
                }
            }
        startActivity(
                FlutterActivity
                    .withCachedEngine(flutterEngineID)
                    .build(this)
            )

    }
}

