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
import java.security.KeyFactory
import java.security.MessageDigest
import java.security.Signature
import java.security.interfaces.RSAPrivateCrtKey
import java.security.spec.PKCS8EncodedKeySpec
import java.util.Base64

class MainActivity : FlutterFragmentActivity() {

    private companion object {
        private const val CHANNEL = "io.beldex.wallet/beldex_wallet_channel"
        private const val EXTRA_IS_SENSITIVE_COMPAT = "android.content.extra.IS_SENSITIVE"
        private const val SIGN_CHANNEL = "io.beldex.wallet/changelly_signer"
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

        MethodChannel(flutterEngine.dartExecutor, SIGN_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "sign" -> {
                        try {
                            val privateKeyHex = call.argument<String>("privateKeyHex")
                                ?: return@setMethodCallHandler result.error("INVALID_ARGUMENT", "privateKeyHex is required", null)
                            val body = call.argument<String>("body")
                                ?: return@setMethodCallHandler result.error("INVALID_ARGUMENT", "body is required", null)

                            val pkcs8Bytes = hexToBytes(privateKeyHex)
                            val keyFactory = KeyFactory.getInstance("RSA")
                            val privateKey = keyFactory.generatePrivate(PKCS8EncodedKeySpec(pkcs8Bytes))

                            val crtKey = privateKey as RSAPrivateCrtKey
                            val publicKey = keyFactory.generatePublic(
                                java.security.spec.RSAPublicKeySpec(crtKey.modulus, crtKey.publicExponent)
                            )
                            val spkiDer = publicKey.encoded
                            val pkcs1Der = ByteArray(spkiDer.size - 24)
                            System.arraycopy(spkiDer, 24, pkcs1Der, 0, pkcs1Der.size)

                            val publicKeyHash = MessageDigest.getInstance("SHA-256").digest(pkcs1Der)
                            val xApiKey = Base64.getEncoder().encodeToString(publicKeyHash)

                            val bodyBytes = body.toByteArray(Charsets.UTF_8)
                            val signer = Signature.getInstance("SHA256withRSA")
                            signer.initSign(privateKey)
                            signer.update(bodyBytes)
                            val xApiSignature = Base64.getEncoder().encodeToString(signer.sign())

                            result.success(hashMapOf(
                                "xApiKey" to xApiKey,
                                "xApiSignature" to xApiSignature
                            ))
                        } catch (e: Exception) {
                            Log.e("MainActivity", "Sign error", e)
                            result.error("SIGN_ERROR", e.message, null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun hexToBytes(hex: String): ByteArray {
        val cleanHex = hex.replace("\\s".toRegex(), "")
        require(cleanHex.length % 2 == 0) { "Hex has odd length" }
        val bytes = ByteArray(cleanHex.length / 2)
        for (i in cleanHex.indices step 2) {
            val high = Character.digit(cleanHex[i], 16)
            val low = Character.digit(cleanHex[i + 1], 16)
            require(high >= 0 && low >= 0) { "Non-hex character" }
            bytes[i / 2] = ((high shl 4) + low).toByte()
        }
        return bytes
    }
}




