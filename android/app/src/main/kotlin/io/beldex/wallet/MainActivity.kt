package io.beldex.wallet

import android.content.Intent
import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {

    private val channel = "io.beldex.wallet/beldex_wallet_channel";
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor, channel)
            .setMethodCallHandler{
                    call, result ->
                if(call.method == "email"){
                    val args = call.arguments as Map<String, Any>
                    val emailId = args["email_id"] as String;
                    val intent = Intent(Intent.ACTION_SENDTO)
                    intent.data = Uri.parse("mailto:")
                    intent.putExtra(Intent.EXTRA_EMAIL, arrayOf(emailId))
                    intent.putExtra(Intent.EXTRA_SUBJECT, "")
                    startActivity(intent)
                    result.success(hashMapOf("test" to ""))
                }else if (call.method == "action_view"){
                    try {
                        val args = call.arguments as Map<String, Any>
                        val url = args["url"] as String;
                        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                        startActivity(intent)
                    } catch (e: Exception) {
                        Log.d("Exception ", e.message.toString())
                    }
                    result.success(hashMapOf("test" to ""))
                }else{
                    result.notImplemented()
                }
            }
    }
}



