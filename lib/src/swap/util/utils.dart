import 'dart:convert';

import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/platform_channel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../util/network_service.dart';

const swapTransactionsListKey = "swap_transaction_list";

String toStringAsFixed(String? amount) {
  final double d = double.parse(amount!);
  final String inString = d>=1.00 ? d.toStringAsFixed(4): d.toStringAsFixed(9);
  return inString;
}

String getDate(int timeStamp) {
  final date = DateTime.fromMicrosecondsSinceEpoch(timeStamp);
  return DateFormat('dd MMM yyyy').format(date);
}

String getDateAndTime(int timeStamp) {
  final date = DateTime.fromMicrosecondsSinceEpoch(timeStamp);
  return DateFormat('dd MMM yyyy, HH:mm:ss').format(date);
}

String getTransactionDate(int timeStamp) {
  final date = DateTime.fromMicrosecondsSinceEpoch(timeStamp);
  return DateFormat('dd MMM yyyy').format(date);
}

String getTransactionTime(int timeStamp) {
  final date = DateTime.fromMicrosecondsSinceEpoch(timeStamp);
  return DateFormat('HH:mm:ss').format(date);
}

String truncateMiddle(String input, {int start = 3, int end = 3}) {
  if (input.length <= start + end) return input;
  return '${input.substring(0, start)}...${input.substring(input.length - end)}';
}

String processUrl(String? url, String? hash) {
  if (url == null || !url.contains('/') || hash == null) return "";

  final int index = url.lastIndexOf('/');
  final String trimmed = url.substring(0, index + 1);

  return '$trimmed$hash';
}

Future<void> openUrl(String? url, MethodChannel methodChannelPlatform) async => await methodChannelPlatform.invokeMethod("action_view",<String, dynamic>{
  'url': url,
});

Future<void> getTransactionsIds(FlutterSecureStorage secureStorage, {void Function(List<String>)? transactionIds}) async {
  // Retrieve the stored array
  transactionIds!(await readMultipleStrings(secureStorage));
}

Future<List<String>> readMultipleStrings(FlutterSecureStorage secureStorage) async {
  final String? encoded = await secureStorage.read(key: swapTransactionsListKey);
  if (encoded == null) return [];

  final List<dynamic> decoded = jsonDecode(encoded);
  return decoded.cast<String>();
}

Future<void> storeMultipleStrings(List<String> strings, FlutterSecureStorage secureStorage) async {
  final encoded = jsonEncode(strings); // Convert list to JSON string
  await secureStorage.write(key: swapTransactionsListKey, value: encoded);
}

Future<List<String>> storeTransactionsIds(String? transactionId, FlutterSecureStorage secureStorage) async {
  // Retrieve the stored array
  final stored = await readMultipleStrings(secureStorage);
  stored.add(transactionId!);
  // Store an array of strings
  await storeMultipleStrings(stored, secureStorage);
  return stored;
}

bool isOnline(BuildContext context) {
  final networkStatus = Provider.of<NetworkStatus>(context, listen: false);
  return networkStatus == NetworkStatus.online;
}

bool syncStatus(SyncStatus status) {
  return status is SyncedSyncStatus || status.blocksLeft == 0;
}