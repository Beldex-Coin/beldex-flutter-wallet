/// Row model for the SQLite `swap_transactions_history` table.
///
/// Each instance maps 1:1 to a row of the table. Field names match the
/// database column names so a row (returned by sqflite as a flat
/// `Map<String, dynamic>`) can be converted without juggling loose casts.
import 'dart:convert';

class SwapTransactionHistoryModel {
  SwapTransactionHistoryModel({
    required this.uuid,
    required this.walletAddress,
    this.exchange = 'changelly',
    required this.txnId,
    this.txnStatus = 'waiting',
    this.txnType = 'float',
    this.swapType = 'normal',
    this.currencyFrom = '',
    this.networkFrom,
    this.blockchainFrom,
    this.currencyTo = '',
    this.networkTo,
    this.blockchainTo,
    this.payinAddress,
    this.payinAddressMemo,
    this.payoutAddress,
    this.payoutAddressMemo,
    this.refundAddress,
    this.refundStatus = 'not_returned',
    this.refundAddressMemo,
    this.amountFrom,
    this.amountTo,
    this.networkFee,
    this.platformFee,
    this.rawResponse,
    required this.createdAt,
    this.updatedAt,
  });

  final String uuid;
  final String walletAddress;
  final String exchange;
  final String txnId;
  final String txnStatus;
  final String txnType;
  final String swapType;
  final String currencyFrom;
  final String? networkFrom;
  final String? blockchainFrom;
  final String currencyTo;
  final String? networkTo;
  final String? blockchainTo;
  final String? payinAddress;
  final String? payinAddressMemo;
  final String? payoutAddress;
  final String? payoutAddressMemo;
  final String? refundAddress;
  final String refundStatus;
  final String? refundAddressMemo;
  final String? amountFrom;
  final String? amountTo;
  final String? networkFee;
  final String? platformFee;
  final dynamic rawResponse;
  final int createdAt;
  final int? updatedAt;

  /// Converts a single sqflite row (`Map<String, dynamic>` keyed by column
  /// name) into a [SwapTransactionHistoryModel].
  factory SwapTransactionHistoryModel.fromRow(Map<String, dynamic> row) {
    return SwapTransactionHistoryModel(
      uuid: _asStr(row['uuid']) ?? '',
      walletAddress: _asStr(row['wallet_address']) ?? '',
      exchange: _asStr(row['exchange']) ?? 'changelly',
      txnId: _asStr(row['txn_id']) ?? '',
      txnStatus: _asStr(row['txn_status']) ?? 'waiting',
      txnType: _asStr(row['txn_type']) ?? 'float',
      swapType: _asStr(row['swap_type']) ?? 'normal',
      currencyFrom: _asStr(row['currency_from']) ?? '',
      networkFrom: _asStr(row['network_from']),
      blockchainFrom: _asStr(row['blockchain_from']),
      currencyTo: _asStr(row['currency_to']) ?? '',
      networkTo: _asStr(row['network_to']),
      blockchainTo: _asStr(row['blockchain_to']),
      payinAddress: _asStr(row['payin_address']),
      payinAddressMemo: _asStr(row['payin_address_memo']),
      payoutAddress: _asStr(row['payout_address']),
      payoutAddressMemo: _asStr(row['payout_address_memo']),
      refundAddress: _asStr(row['refund_address']),
      refundStatus: _asStr(row['refund_status']) ?? 'not_returned',
      refundAddressMemo: _asStr(row['refund_address_memo']),
      amountFrom: _asNumStr(row['amount_from']),
      amountTo: _asNumStr(row['amount_to']),
      networkFee: _asNumStr(row['network_fee']),
      platformFee: _asNumStr(row['platform_fee']),
      rawResponse: row['raw_response'],
      createdAt: _asInt(row['created_at']) ?? 0,
      updatedAt: _asInt(row['updated_at']),
    );
  }

  /// Accessor for the raw API JSON (the `raw_response` column). When the row
  /// holds an encoded JSON string it is decoded to a map; otherwise the
  /// already-parsed map is returned as-is.
  Map<String, dynamic>? get rawResponseMap {
    final raw = rawResponse;
    if (raw is String && raw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } catch (_) {}
    }
    if (raw is Map) {
      return Map<String, dynamic>.from(raw);
    }
    return null;
  }

  /// Exchange rate (units of currency-to per 1 unit of currency-from).
  ///
  /// `rate` is not a table column, so it is derived: prefer the API rate
  /// persisted in `raw_response`, otherwise compute it from the stored
  /// amounts (amountTo / amountFrom).
  String? get rate {
    final raw = rawResponseMap;
    if (raw != null) {
      final stored = raw['rate'];
      if (stored != null) {
        return stored.toString();
      }
    }
    final from = double.tryParse(amountFrom ?? '');
    final to = double.tryParse(amountTo ?? '');
    if (from == null || to == null || from == 0) return null;
    return (to / from).toString();
  }

  static String? _asStr(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  static String? _asNumStr(dynamic value) {
    if (value == null) return null;
    final text = value.toString();
    return text.endsWith('.0') ? text.substring(0, text.length - 2) : text;
  }

  static int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}