// Dear manitainer, if you have to change this file,
// consider changing the one under `tool/generator/static/` too.
package com.example.veryGoodWearosApp

import android.os.Bundle
import androidx.annotation.NonNull
import com.samsung.wearable_rotary.WearableRotaryPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

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
}
