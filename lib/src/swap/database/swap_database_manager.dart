import 'dart:convert';
import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../util/utils.dart' show toMsEpoch;

const String swapDbFileName = 'beldex_wallet.db';

/// SQLite-backed storage for swap transactions.
class SwapDatabaseManager {
  SwapDatabaseManager._();

  static final SwapDatabaseManager instance = SwapDatabaseManager._();

  Database? _db;

  /// Lazily opens the database and creates tables/indexes.
  /// Safe to call repeatedly — returns the cached instance.
  Future<Database> _getDb() async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, swapDbFileName);
    try {
      _db = await _open(dbPath);
    } catch (e) {
      print('[SwapDatabaseManager] Open failed, cycling corrupt file: $e');
      try {
        await deleteDatabase(dbPath);
      } catch (_) {}
      _db = await _open(dbPath);
    }
    print('[SwapDatabaseManager] Database initialized at: $dbPath');
    return _db!;
  }

  Future<Database> _open(String dbPath) {
    return openDatabase(
      dbPath,
      version: 1,
      onConfigure: (db) async {
        try {
          await db.execute('PRAGMA journal_mode = WAL');
        } catch (_) {}
        try {
          await db.execute('PRAGMA synchronous = NORMAL');
        } catch (_) {}
      },
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS swap_transactions_history (
        uuid TEXT PRIMARY KEY NOT NULL,
        wallet_address TEXT NOT NULL,
        exchange TEXT NOT NULL,
        txn_id TEXT NOT NULL,
        txn_status TEXT NOT NULL,
        txn_type TEXT NOT NULL,
        swap_type TEXT NOT NULL,
        currency_from TEXT NOT NULL,
        network_from TEXT,
        blockchain_from TEXT,
        currency_to TEXT NOT NULL,
        network_to TEXT,
        blockchain_to TEXT,
        payin_address TEXT,
        payin_address_memo TEXT,
        payout_address TEXT,
        payout_address_memo TEXT,
        refund_address TEXT,
        refund_status TEXT DEFAULT 'not_returned',
        refund_address_memo TEXT,
        amount_from REAL,
        amount_to REAL,
        network_fee REAL DEFAULT 0,
        platform_fee REAL DEFAULT 0,
        raw_response TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        UNIQUE(exchange, txn_id)
      );
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_swap_txn_wallet_created
        ON swap_transactions_history (wallet_address, created_at DESC);
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_swap_txn_exchange_id
        ON swap_transactions_history (exchange, txn_id);
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS swap_db_metadata (
        key TEXT PRIMARY KEY NOT NULL,
        value TEXT NOT NULL
      );
    ''');
  }

  /// Inserts or updates a swap transaction. Unique on (exchange, txn_id).
  /// Uses ON CONFLICT to preserve earlier non-empty fields while always
  /// refreshing status/fees/raw data.
  ///
  /// When [txn] is provided (i.e. called from [batchUpsertTransactions]) all
  /// statements go through that transaction object instead of the base
  /// database handle: sqflite requires this inside an explicit transaction
  /// and otherwise deadlocks writing on the base connection.
  Future<void> upsertTransaction(Map<String, dynamic> tx, {Transaction? txn}) async {
    final db = txn ?? await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    final rawVal = tx['created_at'] ?? tx['createdAt'] ?? now;
    final createdAt = toMsEpoch(rawVal);

    final payload = {
      'uuid': _randomUuid(),
      'wallet_address': tx['wallet_address'] ?? '',
      'exchange': tx['exchange'] ?? 'changelly',
      'txn_id': tx['txn_id'],
      'txn_status': tx['txn_status'] ?? 'waiting',
      'txn_type': tx['txn_type'] ?? 'float',
      'swap_type': tx['swap_type'] ?? 'normal',
      'currency_from': tx['currency_from'] ?? '',
      'network_from': tx['network_from'],
      'blockchain_from': tx['blockchain_from'],
      'currency_to': tx['currency_to'] ?? '',
      'network_to': tx['network_to'],
      'blockchain_to': tx['blockchain_to'],
      'payin_address': tx['payin_address'],
      'payin_address_memo': tx['payin_address_memo'],
      'payout_address': tx['payout_address'],
      'payout_address_memo': tx['payout_address_memo'],
      'refund_address': tx['refund_address'],
      'refund_status': tx['refund_status'] ?? 'not_returned',
      'refund_address_memo': tx['refund_address_memo'],
      'amount_from': tx['amount_from'] != null ? _toNum(tx['amount_from']) : null,
      'amount_to': tx['amount_to'] != null ? _toNum(tx['amount_to']) : null,
      'network_fee': tx['network_fee'] != null ? _toNum(tx['network_fee']) : 0,
      'platform_fee': tx['platform_fee'] != null ? _toNum(tx['platform_fee']) : 0,
      'raw_response': _encodeRawResponse(tx['raw_response']),
      'created_at': createdAt,
      'updated_at': tx['updated_at'] != null ? _toNum(tx['updated_at']).round() : now,
    };

    final args = <Object?>[
      payload['uuid'], payload['wallet_address'], payload['exchange'], payload['txn_id'],
      payload['txn_status'], payload['txn_type'], payload['swap_type'],
      payload['currency_from'], payload['network_from'], payload['blockchain_from'],
      payload['currency_to'], payload['network_to'], payload['blockchain_to'],
      payload['payin_address'], payload['payin_address_memo'], payload['payout_address'],
      payload['payout_address_memo'], payload['refund_address'], payload['refund_status'],
      payload['refund_address_memo'], payload['amount_from'], payload['amount_to'],
      payload['network_fee'], payload['platform_fee'], payload['raw_response'],
      payload['created_at'], payload['updated_at'],
    ];

    await db.rawInsert('''
      INSERT INTO swap_transactions_history (
        uuid, wallet_address, exchange, txn_id, txn_status, txn_type, swap_type,
        currency_from, network_from, blockchain_from, currency_to, network_to, blockchain_to,
        payin_address, payin_address_memo, payout_address, payout_address_memo,
        refund_address, refund_status, refund_address_memo,
        amount_from, amount_to, network_fee, platform_fee,
        raw_response, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(exchange, txn_id) DO UPDATE SET
        wallet_address = COALESCE(NULLIF(excluded.wallet_address, ''), swap_transactions_history.wallet_address),
        txn_status = excluded.txn_status,
        txn_type = COALESCE(NULLIF(excluded.txn_type, ''), swap_transactions_history.txn_type),
        swap_type = COALESCE(NULLIF(excluded.swap_type, ''), swap_transactions_history.swap_type),
        currency_from = COALESCE(NULLIF(excluded.currency_from, ''), swap_transactions_history.currency_from),
        network_from = COALESCE(excluded.network_from, swap_transactions_history.network_from),
        blockchain_from = COALESCE(excluded.blockchain_from, swap_transactions_history.blockchain_from),
        currency_to = COALESCE(NULLIF(excluded.currency_to, ''), swap_transactions_history.currency_to),
        network_to = COALESCE(excluded.network_to, swap_transactions_history.network_to),
        blockchain_to = COALESCE(excluded.blockchain_to, swap_transactions_history.blockchain_to),
        payin_address = COALESCE(excluded.payin_address, swap_transactions_history.payin_address),
        payin_address_memo = COALESCE(excluded.payin_address_memo, swap_transactions_history.payin_address_memo),
        payout_address = COALESCE(excluded.payout_address, swap_transactions_history.payout_address),
        payout_address_memo = COALESCE(excluded.payout_address_memo, swap_transactions_history.payout_address_memo),
        refund_address = COALESCE(excluded.refund_address, swap_transactions_history.refund_address),
        refund_status = COALESCE(excluded.refund_status, swap_transactions_history.refund_status),
        refund_address_memo = COALESCE(excluded.refund_address_memo, swap_transactions_history.refund_address_memo),
        amount_from = COALESCE(excluded.amount_from, swap_transactions_history.amount_from),
        amount_to = COALESCE(excluded.amount_to, swap_transactions_history.amount_to),
        network_fee = COALESCE(excluded.network_fee, swap_transactions_history.network_fee),
        platform_fee = COALESCE(excluded.platform_fee, swap_transactions_history.platform_fee),
        raw_response = COALESCE(excluded.raw_response, swap_transactions_history.raw_response),
        created_at = swap_transactions_history.created_at,
        updated_at = excluded.updated_at
    ''', args);

    print('[SwapDB] upsert txn_id=${payload['txn_id']} | network_from=${payload['network_from']} | network_to=${payload['network_to']}');
  }

  Future<void> batchUpsertTransactions(List<Map<String, dynamic>> txArray) async {
    final db = await _getDb();
    await db.transaction((txn) async {
      for (final tx in txArray) {
        await upsertTransaction(tx, txn: txn);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getOrderHistory(String walletAddress, {int page = 1, int pageSize = 7}) async {
    if (walletAddress.isEmpty) return [];
    final db = await _getDb();
    final limit = max(1, pageSize);
    final offset = max(0, (max(1, page) - 1) * limit);
    return db.rawQuery(
      'SELECT * FROM swap_transactions_history WHERE wallet_address = ? ORDER BY created_at DESC LIMIT ? OFFSET ?',
      [walletAddress, limit, offset],
    );
  }

  Future<List<Map<String, dynamic>>> getAllOrderHistory(String walletAddress) async {
    if (walletAddress.isEmpty) return [];
    final db = await _getDb();
    return db.rawQuery(
      'SELECT * FROM swap_transactions_history WHERE wallet_address = ? ORDER BY created_at DESC',
      [walletAddress],
    );
  }

  Future<int> getOrderHistoryCount(String walletAddress) async {
    if (walletAddress.isEmpty) return 0;
    final db = await _getDb();
    final rows = await db.rawQuery(
      'SELECT COUNT(*) as count FROM swap_transactions_history WHERE wallet_address = ?',
      [walletAddress],
    );
    return rows.isNotEmpty ? (rows.first['count'] as int?) ?? 0 : 0;
  }

  Future<Map<String, dynamic>?> getTxnByProviderId(String exchange, String txnId) async {
    if (exchange.isEmpty || txnId.isEmpty) return null;
    final db = await _getDb();
    final rows = await db.rawQuery(
      'SELECT * FROM swap_transactions_history WHERE exchange = ? AND txn_id = ? LIMIT 1',
      [exchange, txnId],
    );
    return rows.isNotEmpty ? rows.first : null;
  }

  Future<Map<String, dynamic>?> getTxnById(String txnId) async {
    if (txnId.isEmpty) return null;
    final db = await _getDb();
    final rows = await db.rawQuery(
      'SELECT * FROM swap_transactions_history WHERE txn_id = ? LIMIT 1',
      [txnId],
    );
    return rows.isNotEmpty ? rows.first : null;
  }

  Future<Set<String>> getExistingTxnIds(String walletAddress) async {
    if (walletAddress.isEmpty) return {};
    final db = await _getDb();
    final rows = await db.rawQuery(
      'SELECT txn_id FROM swap_transactions_history WHERE wallet_address = ?',
      [walletAddress],
    );
    return rows.map((row) => row['txn_id'] as String).toSet();
  }

  Future<bool> isWalletMigrated(String walletAddress) async {
    if (walletAddress.isEmpty) return false;
    final value = await _getMeta('migrated_wallet:$walletAddress');
    return value == 'true';
  }

  Future<void> markWalletMigrated(String walletAddress) async {
    if (walletAddress.isEmpty) return;
    await _setMeta('migrated_wallet:$walletAddress', 'true');
  }

  Future<String?> _getMeta(String key) async {
    final db = await _getDb();
    final rows = await db.rawQuery('SELECT value FROM swap_db_metadata WHERE key = ?', [key]);
    return rows.isNotEmpty ? rows.first['value'] as String? : null;
  }

  Future<void> _setMeta(String key, String value) async {
    final db = await _getDb();
    await db.rawInsert(
      'INSERT INTO swap_db_metadata (key, value) VALUES (?, ?) ON CONFLICT(key) DO UPDATE SET value = excluded.value',
      [key, value],
    );
  }

  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
      print('[SwapDatabaseManager] Database closed cleanly.');
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

  static double _toNum(dynamic value) => double.tryParse(value.toString()) ?? 0.0;

  /// Encodes a raw API response for storage, or returns `null` when the value
  /// is absent or empty so the SQL UPSERT (COALESCE) keeps the existing data
  /// instead of overwriting it.
  static String? _encodeRawResponse(dynamic raw) {
    if (raw == null) return null;
    if (raw is String) return raw.isEmpty ? null : raw;
    if (raw is Map) return raw.isEmpty ? null : jsonEncode(raw);
    if (raw is List) return raw.isEmpty ? null : jsonEncode(raw);
    if (raw is num || raw is bool) return raw.toString();
    return jsonEncode(raw);
  }
}
