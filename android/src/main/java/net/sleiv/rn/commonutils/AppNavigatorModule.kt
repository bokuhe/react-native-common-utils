package net.sleiv.rn.commonutils

import android.content.Intent
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.delay
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlin.system.exitProcess

@Suppress("unused")
class AppNavigatorModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
  override fun getName(): String {
    return "AppNavigator"
  }

  @ReactMethod
  fun backToPreviousApp(promise: Promise) {
    try {
      currentActivity?.run {
        moveTaskToBack(true)
        promise.resolve(true)
      } ?: promise.reject("NO_ACTIVITY", "Current activity not found.")
    } catch (e: Exception) {
      promise.reject("ERROR", "An error occurred while moving task to back.", e)
    }
  }

  @DelicateCoroutinesApi
  @ReactMethod
  fun exitApp(promise: Promise) {
    try {
      val homeIntent = Intent(Intent.ACTION_MAIN).apply {
        addCategory(Intent.CATEGORY_HOME)
        flags = Intent.FLAG_ACTIVITY_NEW_TASK
      }
      currentActivity?.startActivity(homeIntent) ?: run {
        promise.reject("NO_CURRENT_ACTIVITY", "No current activity found")
        return
      }

      GlobalScope.launch {
        delay(1000)
        //android.os.Process.killProcess(android.os.Process.myPid())
        exitProcess(0)
      }
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject("ERROR", e.message, e)
    }
  }
}
