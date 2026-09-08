import 'dart:convert';
import 'package:beldex_wallet/src/swap/apiKeys.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/models/quickex_api_result.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/quickex_api_config.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/quickex_hmac_signer.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/models/quickex_instrument.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/models/quickex_order.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/models/quickex_pair.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/models/quickex_rate.dart';
import 'package:beldex_wallet/src/swap/model/validate_address_model.dart';
import 'package:http/http.dart' as http;

// ---------------------------------------------------------------------------
// Error handler – QuickEX _handleError
// ---------------------------------------------------------------------------

QuickexApiResult<T> _handleError<T>(String method, dynamic err, Map<String, dynamic>? errorData, Map<String, dynamic>? params) {
  final errMessage = errorData?['message']?.toString() ??
      (err is Exception ? err.toString().replaceFirst('Exception: ', '') : err?.toString()) ??
      'Unknown error';

  print('[quickex_adapter] error: $method $errMessage');

  final targets = <Map<String, dynamic>?>[
    errorData?['data'] is Map<String, dynamic> ? errorData!['data']['details'] as Map<String, dynamic>? : null,
    errorData?['details'] as Map<String, dynamic>?,
    errorData?['data'] is Map<String, dynamic> ? errorData!['data'] as Map<String, dynamic>? : null,
    errorData,
  ];

  String? expectedAmount;
  for (final t in targets) {
    final val = t?['expectedGeneral']?.toString() ?? t?['expected']?.toString();
    if (val != null) {
      expectedAmount = val;
      break;
    }
  }

  expectedAmount ??= _parseExpectedFromMessage(errMessage);

  if (expectedAmount != null) {
    QuickexMinMaxHint minMaxHint;
    if (errMessage.contains('Amount Too Small')) {
      minMaxHint = QuickexMinMaxHint(
        minAmountFloat: expectedAmount,
        maxAmountFloat: '0',
        minAmountFixed: expectedAmount,
      );
    } else if (errMessage.contains('Amount Too Big')) {
      minMaxHint = QuickexMinMaxHint(
        minAmountFloat: '0',
        maxAmountFloat: expectedAmount,
        minAmountFixed: '0',
      );
    } else {
      minMaxHint = QuickexMinMaxHint(minAmountFloat: expectedAmount);
    }

    return QuickexApiResult.error(
      '$errMessage. Expected: $expectedAmount',
      method: method,
      minMaxHint: minMaxHint,
    );
  }

  return QuickexApiResult.error(errMessage, method: method);
}

String? _parseExpectedFromMessage(String message) {
  final match = RegExp(r'expected[:\s]+(\d+\.?\d*)', caseSensitive: false).firstMatch(message);
  return match?.group(1);
}

class QuickexApiService {
  final _publicKey = ApiKeys.quickexPublicKey;
  final _secretKey = ApiKeys.quickexSecretKey;
  final _referrerId = ApiKeys.quickexReferrerId;

  Map<String, String> _signedHeaders(String body, {String? queryString}) {
    final timestamp = QuickexHmacSigner.timestampMs();
    final bodyString = body.isNotEmpty ? body : (queryString ?? '');
    final signature = QuickexHmacSigner.sign(timestamp, bodyString, _publicKey, _secretKey);
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Api-Public-Key': _publicKey,
      'X-Api-Timestamp': timestamp,
      'X-Api-Signature': signature,
    };
  }

  Map<String, String> _baseHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
  }

// ---------------------------------------------------------------------------
// Exported API functions
// ---------------------------------------------------------------------------

  Future<List<QuickexInstrument>> getInstruments() async {
    try {
      final response = await http.get(
        Uri.parse(QuickexApiConfig.instrumentsPublic),
        headers: _baseHeaders(),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        return data
            .map((e) => QuickexInstrument.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Quickex getInstruments error: $e');
    }
    return [];
  }

  Future<QuickexApiResult<QuickexPair>> getPairs({
    required String fromCurrency,
    required String fromNetwork,
    required String toCurrency,
    required String toNetwork,
    required String amount,
    String rateMode = 'FLOATING'
  }) async {
    try {
      final queryParams = {
        'instrumentFromCurrencyTitle': fromCurrency,
        'instrumentFromNetworkTitle': fromNetwork,
        'instrumentToCurrencyTitle': toCurrency,
        'instrumentToNetworkTitle': toNetwork,
        'claimedDepositAmount': amount,
        'rateMode': rateMode,
        'claimedDepositAmountCurrency': fromCurrency,
        'exchangeType': 'crypto',
        'referrerId': _referrerId
      };
      final uri = Uri.parse(QuickexApiConfig.ratesPublicOne).replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: _baseHeaders());
      print('[quickex_api] getPairs status=${response.statusCode}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data.containsKey('status') && data['status'] != null) {
          return _handleError('getPairs', null, data, queryParams);
        }
        return QuickexApiResult.ok(QuickexPair.fromJson(data), method: 'getPairs');
      } else {
        Map<String, dynamic>? errorData;
        try {
          errorData = json.decode(response.body) as Map<String, dynamic>;
        } catch (_) {}
        return _handleError('getPairs', 'HTTP ${response.statusCode}', errorData, queryParams);
      }
    } catch (e) {
      print('Quickex getPairs error: $e');
      return _handleError('getPairs', e, null, null);
    }
  }

  Future<QuickexApiResult<QuickexRate>> getRate({
    required String fromCurrency,
    required String fromNetwork,
    required String toCurrency,
    required String toNetwork,
    required String amount,
    String rateMode = 'FLOATING'
  }) async {
    try {
      final queryParams = {
        'instrumentFromCurrencyTitle': fromCurrency,
        'instrumentFromNetworkTitle': fromNetwork,
        'instrumentToCurrencyTitle': toCurrency,
        'instrumentToNetworkTitle': toNetwork,
        'claimedDepositAmount': amount,
        'rateMode': rateMode,
        'claimedDepositAmountCurrency': fromCurrency,
        'exchangeType': 'crypto',
        'referrerId': _referrerId
      };
      final uri = Uri.parse(QuickexApiConfig.ratesPublicOne).replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: _baseHeaders());
      print('[quickex_api] getRate status=${response.statusCode}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data.containsKey('status') && data['status'] != null) {
          return _handleError('getRate', null, data, queryParams);
        }
        return QuickexApiResult.ok(QuickexRate.fromJson(data), method: 'getRate');
      } else {
        Map<String, dynamic>? errorData;
        try {
          errorData = json.decode(response.body) as Map<String, dynamic>;
        } catch (_) {}
        return _handleError('getRate', 'HTTP ${response.statusCode}', errorData, queryParams);
      }
    } catch (e) {
      print('Quickex getRate error: $e');
      return _handleError('getRate', e, null, null);
    }
  }

  Future<ValidateAddressResult?> validateAddress({
    required String currency,
    required String network,
    required String address,
    String? memo,
  }) async {
    try {
      final bodyMap = <String, dynamic>{
        'currencyTitle': currency,
        'networkTitle': network,
        'address': address,
      };
      if (memo != null && memo.isNotEmpty) {
        bodyMap['memo'] = memo;
      }
      final body = json.encode(bodyMap);
      final response = await http.post(
        Uri.parse(QuickexApiConfig.instrumentsValidateAddress),
        headers: _baseHeaders(),
        body: body,
      );
      print('[quickex_api] validate-address status=${response.statusCode}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        return _parseValidateAddress(response.body);
      }
      return ValidateAddressResult(
        result: false,
        message: 'Invalid address',
      );
    } catch (e) {
      print('Quickex validateAddress error: $e');
      return ValidateAddressResult(result: false, message: 'Invalid address');
    }
  }

  /// Quickex returns validation as either a bare JSON boolean (`true`) or an
  /// object carrying `result`/`valid` plus an optional `message`. A bare
  /// `false` carries no reason, so a default "Invalid address" is surfaced.
  ValidateAddressResult _parseValidateAddress(String body) {
    try {
      final decoded = json.decode(body);
      if (decoded is bool) {
        return ValidateAddressResult(
          result: decoded,
          message: decoded ? null : 'Invalid address',
        );
      }
      if (decoded is Map<String, dynamic>) {
        final rawResult = decoded['result'] ?? decoded['valid'];
        final result = rawResult is bool
            ? rawResult
            : rawResult == true
                ? true
                : false;
        return ValidateAddressResult(
          result: result,
          message: decoded['message']?.toString() ??
              (result ? null : 'Invalid address'),
        );
      }
      return ValidateAddressResult(result: false);
    } catch (_) {
      return ValidateAddressResult(
        result: body.trim() == 'true',
        message: body,
      );
    }
  }

  Future<QuickexOrder?> createOrder({
    required String fromCurrency,
    required String fromNetwork,
    required String toCurrency,
    required String toNetwork,
    required String destinationAddress,
    required String depositAmount,
    String? destinationAddressMemo,
    String? refundAddress,
    String? refundAddressMemo,
    String? rate,
    String? networkFee,
    String rateMode = 'FLOATING',
    String? markup
  }) async {
    try {
      final bodyMap = <String, dynamic>{
        "instrumentFrom": {
          "currencyTitle": fromCurrency.toUpperCase(),
          "networkTitle": fromNetwork.toUpperCase(),
        },
        "instrumentTo": {
          "currencyTitle": toCurrency.toUpperCase(),
          "networkTitle": toNetwork.toUpperCase(),
        },
        "destinationAddress": destinationAddress,
        "refundAddress": refundAddress ?? "",
        "claimedDepositAmount": depositAmount,
        "rateMode": rateMode,
        "referrerId": _referrerId
      };
      if (destinationAddressMemo != null && destinationAddressMemo.isNotEmpty) bodyMap["destinationAddressMemo"] = destinationAddressMemo;
      if (refundAddressMemo != null && refundAddressMemo.isNotEmpty) bodyMap["refundAddressMemo"] = refundAddressMemo;
      final body = json.encode(bodyMap);
      final headers = _signedHeaders(body);
      final response = await http.post(
        Uri.parse(QuickexApiConfig.createOrder),
        headers: headers,
        body: body,
      );
      print('[quickex_api] createOrder status=${response.statusCode}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return QuickexOrder.fromJson(data);
      } else {
        Map<String, dynamic>? errorData;
        try {
          errorData = json.decode(response.body) as Map<String, dynamic>;
        } catch (_) {}
        return _handleError('createOrder', 'HTTP ${response.statusCode}', errorData, null).data as QuickexOrder?;
      }
    } catch (e) {
      print('Quickex createOrder error: $e');
    }
    return null;
  }

  Future<QuickexOrder?> getOrderInfo(String orderId, {String? destinationAddress}) async {
    try {
      final destAddress = destinationAddress?.isNotEmpty == true
          ? destinationAddress
          : null;
      final queryParams = <String, String>{'orderId': orderId.toString()};
      var queryString = 'orderId=$orderId';
      if (destAddress != null) {
        queryParams['destinationAddress'] = destAddress;
        queryString += '&destinationAddress=${Uri.encodeQueryComponent(destAddress)}';
      }
      final uri = Uri.parse(QuickexApiConfig.orderInfo).replace(
        queryParameters: queryParams,
      );
      final headers = _signedHeaders('', queryString: queryString);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return QuickexOrder.fromJson(data);
      } else {
        Map<String, dynamic>? errorData;
        try {
          errorData = json.decode(response.body) as Map<String, dynamic>;
        } catch (_) {}
        final errStatus = errorData?['status']?.toString();
        if (response.statusCode == 410 ||
            errStatus == 'ERR_ORDER_EXPIRED' ||
            (errorData?['message']?.toString().toLowerCase().contains('expired') ?? false)) {
          return QuickexOrder(
            orderId: orderId,
            orderEvents: const [],
            expired: true,
            rawJson: {},
          );
        }
        return _handleError('getOrder', 'HTTP ${response.statusCode}', errorData, null).data as QuickexOrder?;
      }
    } catch (e) {
      print('Quickex getOrderInfo error: $e');
    }
    return null;
  }
}
