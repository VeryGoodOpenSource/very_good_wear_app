// Dear manitainer, if you have to change this file,
// consider changing the one under `tool/generator/static/` too.
package com.example.veryGoodWearosApp

import android.os.Bundle
import androidx.annotation.NonNull
import android.view.MotionEvent
import com.samsung.wearable_rotary.WearableRotaryPlugin
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.wear.ambient.AmbientModeSupport

class MainActivity : FlutterFragmentActivity(), AmbientModeSupport.AmbientCallbackProvider {
    private lateinit var channel: MethodChannel
    private lateinit var ambientController: AmbientModeSupport.AmbientController

    companion object {
        const val CHANNEL = "ambient_mode"
    }

    /**
     * A method to hook rotary input events into the "WearableRotaryPlugin" class.
     */
    override fun onGenericMotionEvent(event: MotionEvent?): Boolean {
        return when {
            WearableRotaryPlugin.onGenericMotionEvent(event) -> true
            else -> super.onGenericMotionEvent(event)
        }
    }

    /**
     * Makes the app assume the rounded canvas appearance on rounded screens.
     */
    override fun onCreate(savedInstanceState: Bundle?) {
        intent.putExtra("background_mode", "transparent")
        super.onCreate(savedInstanceState)
    }


    /**
     * Uppon the engine initialization, the ambient mode method channel is created and
     * an ambient mode controller is attached to the activity.
     */
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        ambientController = AmbientModeSupport.attach(this)
    }

    override fun getAmbientCallback(): AmbientModeSupport.AmbientCallback = FlutterAmbientCallback()


    /**
     * A callback class to handle ambient mode events.
     */
    private inner class FlutterAmbientCallback : AmbientModeSupport.AmbientCallback() {
        override fun onEnterAmbient(ambientDetails: Bundle?) {
            channel.invokeMethod("onEnterAmbient", null)
        }

        override fun onExitAmbient() {
            channel.invokeMethod("onExitAmbient", null)
        }

        override fun onUpdateAmbient() {
            channel.invokeMethod("onUpdateAmbient", null)
        }
    }
}
