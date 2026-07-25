package io.beldex.wallet

import android.content.ClipData
import android.content.ClipDescription
import android.content.ClipboardManager
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import androidx.activity.enableEdgeToEdge
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import androidx.core.net.toUri

class MainActivity : FlutterFragmentActivity() {

    private companion object {
        private const val CHANNEL = "io.beldex.wallet/beldex_wallet_channel"
        private const val EXTRA_IS_SENSITIVE_COMPAT = "android.content.extra.IS_SENSITIVE"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "email" -> {
                        val emailId = call.argument<String>("email_id")
                            ?: return@setMethodCallHandler result.error(
                                "INVALID_ARGUMENT",
                                "Email is required",
                                null
                            )
                        val intent = Intent(Intent.ACTION_SENDTO)
                        intent.data = "mailto:".toUri()
                        intent.putExtra(Intent.EXTRA_EMAIL, arrayOf(emailId))
                        intent.putExtra(Intent.EXTRA_SUBJECT, "")
                        startActivity(intent)
                        result.success(hashMapOf("test" to ""))
                    }

                    "action_view" -> {
                        try {
                            val url = call.argument<String>("url")
                                ?: return@setMethodCallHandler result.error(
                                    "INVALID_ARGUMENT",
                                    "URL is required",
                                    null
                                )

                            val intent = Intent(Intent.ACTION_VIEW, url.toUri())
                            startActivity(intent)
                            result.success(hashMapOf("test" to ""))
                        } catch (e: Exception) {
                            Log.e("MainActivity", "Failed to open URL", e)
                            result.error("ACTION_VIEW_ERROR", e.message, null)
                        }
                    }

                    "copySensitiveClipboard" -> {
                        val text = (call.argument<String>("text")
                            ?: return@setMethodCallHandler result.error("INVALID_ARGUMENT", "Text is required", null))
                        val clipboard = getSystemService(CLIPBOARD_SERVICE) as ClipboardManager
                        val clip = ClipData.newPlainText("beldex_sensitive", text)
                        val sensitiveKey =
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                                ClipDescription.EXTRA_IS_SENSITIVE
                            } else {
                                EXTRA_IS_SENSITIVE_COMPAT
                            }
                        clip.description.extras = PersistableBundle().apply {
                            putBoolean(sensitiveKey, true)
                        }
                        clipboard.setPrimaryClip(clip)
                        result.success(true)
                    }

                    "clearClipboard" -> {
                        val clipboard = getSystemService(CLIPBOARD_SERVICE) as ClipboardManager
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                            clipboard.clearPrimaryClip()
                        } else {
                            val clip = ClipData.newPlainText("", "")
                            clipboard.setPrimaryClip(clip)
                        }
                        result.success(true)
                    }

                    else -> result.notImplemented()
                }
            }
    }
}




