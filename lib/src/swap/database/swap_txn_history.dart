import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../api_service/get_transactions_api_service.dart';
import '../../util/constants.dart';
import '../util/utils.dart' show toMsEpoch;
import 'swap_database_manager.dart';
import 'swap_transaction_history_model.dart';

/// Transaction history service backed by the SQLite [SwapDatabaseManager].
///
/// `SwapTxnHistory` class: provides CRUD over the
/// swap DB and migrates the legacy `swap_transaction_history.json` store into
/// SQLite (fetching missing transaction details from the Changelly API).
class SwapTxnHistory {
  SwapTxnHistory._();

  static final SwapTxnHistory instance = SwapTxnHistory._();

  SwapDatabaseManager get dbManager => SwapDatabaseManager.instance;

  Future<String> _getSwapHistoryPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, swapTransactionHistoryFileName);
  }

  Future<List<Map<String, dynamic>>> getOrderHistory(String address) async {
    if (address.isEmpty) return [];
    return dbManager.getAllOrderHistory(address);
  }

  Future<({List<Map<String, dynamic>> transactions, int totalCount})>
      getPaginatedOrderHistory(String address, {int page = 1, int pageSize = 7}) async {
    if (address.isEmpty) return (transactions: <Map<String, dynamic>>[], totalCount: 0);
    final transactions = await dbManager.getOrderHistory(address, page: page, pageSize: pageSize);
    final totalCount = await dbManager.getOrderHistoryCount(address);
    return (transactions: transactions, totalCount: totalCount);
  }

  /// Loads the full swap history for [address] as typed row models mirroring
  /// the `swap_transactions_history` table columns.
  Future<List<SwapTransactionHistoryModel>> getOrderHistoryModels(String address) async {
    final records = await getOrderHistory(address);
    return records.map(SwapTransactionHistoryModel.fromRow).toList();
  }

  Future<String?> getTxnExchange(String txnId, String walletAddress) async {
    if (txnId.isEmpty) return null;
    if (walletAddress.isNotEmpty) {
      final orders = await dbManager.getAllOrderHistory(walletAddress);
      final found = orders.where((t) => '${t['txn_id']}' == txnId).toList();
      if (found.isNotEmpty && found.first['exchange'] != null) {
        return found.first['exchange'] as String;
      }
    }
    final record = await dbManager.getTxnById(txnId);
    return record != null ? record['exchange'] as String? : null;
  }

  Map<String, dynamic> mapDetailsToRecord(
    String txnId,
    String address, {
    bool isPrivacySwap = false,
    String exchangeType = 'changelly',
    Map<String, dynamic> details = const {},
  }) {
    final swapType = isPrivacySwap ? 'privacy' : 'normal';
    final now = DateTime.now().millisecondsSinceEpoch;
    final rawCreatedAt = details['createdAt'] ?? details['created_at'];
    final createdAt = rawCreatedAt != null ? toMsEpoch(rawCreatedAt) : now;
    final extractAddr = (dynamic val) {
      if (val == null) return null;
      if (val is String) return val;
      if (val is Map) {
        return val['depositAddress'] ??
            val['destinationAddress'] ??
            val['refundAddress'] ??
            val['address'];
      }
      return null;
    };

    final extractMemo = (dynamic val) {
      if (val == null) return null;
      if (val is String) return val;
      if (val is Map) {
        return val['depositAddressMemo'] ??
            val['destinationAddressMemo'] ??
            val['refundAddressMemo'] ??
            val['memo'];
      }
      return null;
    };

    return {
      'uuid': _randomUuid(),
      'wallet_address': address,
      'exchange': exchangeType.isNotEmpty ? exchangeType : 'changelly',
      'txn_id': txnId,
      'txn_status': details['status'] ?? 'waiting',
      'txn_type': details['type'] ?? 'float',
      'swap_type': swapType,
      'currency_from': details['currencyFrom'] ?? '',
      'network_from': details['networkFrom'],
      'blockchain_from': details['blockchainFrom'],
      'currency_to': details['currencyTo'] ?? '',
      'network_to': details['networkTo'],
      'blockchain_to': details['blockchainTo'],
      'payin_address': extractAddr(details['payinAddress'] ?? details['depositAddress']),
      'payin_address_memo': extractMemo(
        details['payinExtraId'] ?? details['depositAddressMemo'] ?? details['depositAddress']),
      'payout_address': extractAddr(details['payoutAddress'] ?? details['destinationAddress']),
      'payout_address_memo': extractMemo(
        details['payoutExtraId'] ?? details['destinationAddressMemo'] ?? details['destinationAddress']),
      'refund_address': extractAddr(details['refundAddress']),
      'refund_status': details['refundStatus'] ?? 'not_returned',
      'refund_address_memo': extractMemo(
        details['refundExtraId'] ?? details['refundAddressMemo'] ?? details['refundAddress']),
      'amount_from': details['amountExpectedFrom'] ?? details['amountFrom'],
      'amount_to': details['amountExpectedTo'] ?? details['amountTo'],
      'network_fee': details['networkFee'] ?? details['apiExtraFee'] ?? 0,
      'platform_fee': details['platformFee'] ?? details['changellyFee'] ?? 0,
      'raw_response': details['raw_response'] ?? details['rawResponse'] ?? details,
      'created_at': createdAt,
      'updated_at': now,
    };
  }

  Future<Map<String, dynamic>?> updateTransactionDetails(
    String txnId,
    String address, {
    bool isPrivacySwap = false,
    String exchangeType = 'changelly',
    Map<String, dynamic> details = const {},
  }) async {
    if (txnId.isEmpty || address.isEmpty) {
      print('[SwapTxnHistory] Skipped update: missing txn_id or address { $txnId, $address }');
      return null;
    }
    final record = mapDetailsToRecord(
      txnId,
      address,
      isPrivacySwap: isPrivacySwap,
      exchangeType: exchangeType,
      details: details,
    );
    try {
      await dbManager.upsertTransaction(record);
      return record;
    } catch (err) {
      print('[SwapTxnHistory] updateTransactionDetails failed for txn_id $txnId: $err');
      return null;
    }
  }

  /// Migrates the legacy JSON transaction store into SQLite, fetching missing
  /// transaction details from the Changelly API.
  /// Including the "already migrated" guards and stale-ID cleanup.
  Future<void> migrateSwapHistory(String walletAddress) async {
    if (walletAddress.isEmpty) {
      print('[SwapTxnHistory] migrateSwapHistory requires a walletAddress.');
      return;
    }

    if (await dbManager.isWalletMigrated(walletAddress)) {
      print('[SwapTxnHistory] Migration completed for $walletAddress.');
      return;
    }

    final path = await _getSwapHistoryPath();
    Map<String, dynamic> swapHistory;
    try {
      final raw = await File(path).readAsString();
      swapHistory = jsonDecode(raw) as Map<String, dynamic>;
    } catch (err) {
      print('[SwapTxnHistory] Failed to read swap_transaction_history.json: $err');
      await dbManager.markWalletMigrated(walletAddress);
      return;
    }

    if (!swapHistory.containsKey(walletAddress)) {
      await dbManager.markWalletMigrated(walletAddress);
      return;
    }

    final rawIds = swapHistory[walletAddress];
    if (rawIds is! List || rawIds.isEmpty) {
      await dbManager.markWalletMigrated(walletAddress);
      return;
    }

    final jsonTxnIds = rawIds.map((id) => '$id').toSet().toList();
    if (jsonTxnIds.isEmpty) {
      await dbManager.markWalletMigrated(walletAddress);
      return;
    }

    final dbCount = await dbManager.getOrderHistoryCount(walletAddress);

    // Guard 1: JSON count matches DB count.
    if (jsonTxnIds.length == dbCount) {
      await dbManager.markWalletMigrated(walletAddress);
      print('[SwapTxnHistory] Guard: JSON(${jsonTxnIds.length}) == DB($dbCount) for $walletAddress');
      return;
    }

    // Guard 2: all JSON ids already present in DB.
    final existingDbTxnIds = await dbManager.getExistingTxnIds(walletAddress);
    final missingTxnIds = jsonTxnIds.where((id) => !existingDbTxnIds.contains(id)).toList();
    if (missingTxnIds.isEmpty) {
      await dbManager.markWalletMigrated(walletAddress);
      print('[SwapTxnHistory] Guard: All ${jsonTxnIds.length} ids already in DB for $walletAddress');
      return;
    }

    print('[SwapTxnHistory] Migrating ${missingTxnIds.length} missing ids for $walletAddress');

    final fetchedRecordsMap = <String, Map<String, dynamic>>{};
    final transactionsApi = GetTransactionsApiService();
    var apiFailed = false;

    for (var i = 0; i < missingTxnIds.length && !apiFailed; i += 10) {
      final chunk = missingTxnIds.sublist(i, min(i + 10, missingTxnIds.length));
      try {
        final response = await transactionsApi.getSignatureWithIds({'id': chunk});
        if (response != null && response.result != null) {
          for (final item in response.result!) {
            if (item.id != null) {
              fetchedRecordsMap['${item.id}'] = {
                ...item.toJson(),
              };
            }
          }
        } else {
          print('[SwapTxnHistory] API Error fetching migration batch');
          apiFailed = true;
        }
      } catch (apiErr) {
        print('[SwapTxnHistory] Error fetching migration batch: $apiErr');
        apiFailed = true;
      }
    }

    if (apiFailed) {
      print('[SwapTxnHistory] Migration aborted for $walletAddress due to API error.');
      return;
    }

    final staleIds = missingTxnIds.where((id) => !fetchedRecordsMap.containsKey(id)).toList();

    final recordsToInsert = <Map<String, dynamic>>[];
    for (final txnId in missingTxnIds) {
      final fetchedItem = fetchedRecordsMap[txnId];
      if (fetchedItem == null) continue;
      recordsToInsert.add(mapDetailsToRecord(
        txnId,
        walletAddress,
        isPrivacySwap: false,
        exchangeType: 'changelly',
        details: fetchedItem,
      ));
    }

    try {
      await dbManager.batchUpsertTransactions(recordsToInsert);
      await dbManager.markWalletMigrated(walletAddress);
      await _removeStaleIdsFromJson(walletAddress, staleIds);
      print('[SwapTxnHistory] Migration completed for $walletAddress. '
          'Migrated ${recordsToInsert.length}, removed ${staleIds.length} stale ids.');
    } catch (dbErr) {
      print('[SwapTxnHistory] Failed to persist migration batch for $walletAddress: $dbErr');
    }
  }

  Future<void> _removeStaleIdsFromJson(String walletAddress, List<String> staleIds) async {
    if (staleIds.isEmpty) return;
    final path = await _getSwapHistoryPath();
    try {
      final raw = await File(path).readAsString();
      final swapHistory = jsonDecode(raw) as Map<String, dynamic>;
      final list = swapHistory[walletAddress];
      if (list is! List) return;

      final staleSet = staleIds.map((id) => id.toString()).toSet();
      swapHistory[walletAddress] =
          list.where((id) => !staleSet.contains('$id')).toList();

      if ((swapHistory[walletAddress] as List).isEmpty) {
        swapHistory.remove(walletAddress);
      }

      if (swapHistory.isEmpty) {
        await File(path).delete();
        print('[SwapTxnHistory] Deleted empty swap_transaction_history.json');
      } else {
        await File(path).writeAsString(jsonEncode(swapHistory), flush: true);
      }
      print('[SwapTxnHistory] Removed ${staleIds.length} stale ids from JSON for $walletAddress');
    } catch (err) {
      print('[SwapTxnHistory] JSON cleanup warning: $err');
    }
  }

  static String _randomUuid() {
    final rng = Random.secure();
    final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
