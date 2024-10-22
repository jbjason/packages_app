package com.example.packages_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity: FlutterActivity(){
    private val CHANNEL = "flutter.native/helper"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getDeviceInfo") {
                val deviceInfo = HashMap<String, String>()
                deviceInfo["version"] = System.getProperty("os.version")!!.toString()
                deviceInfo["device"] = android.os.Build.DEVICE
                deviceInfo["model"] = android.os.Build.MODEL
                deviceInfo["product"] = android.os.Build.PRODUCT
                deviceInfo["manufacturer"] =  android.os.Build.MANUFACTURER
                deviceInfo["sdkVersion"] =  android.os.Build.VERSION.SDK_INT.toString()
                deviceInfo["id"] =  android.os.Build.ID

                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    deviceInfo["battery"] = batteryLevel.toString()
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
                if (deviceInfo.isNotEmpty()) {
                    result.success(deviceInfo)
                } else {
                    result.error("UNAVAILABLE", "Device info not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                    null,
                    IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel =
                    intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                            BatteryManager.EXTRA_SCALE,
                            -1
                    )
        }
        return batteryLevel
    }
}
