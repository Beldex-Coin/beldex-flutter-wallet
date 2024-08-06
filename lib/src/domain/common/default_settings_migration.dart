import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beldex_wallet/src/node/node.dart';
import 'package:beldex_wallet/src/domain/common/balance_display_mode.dart';
import 'package:beldex_wallet/src/domain/common/fiat_currency.dart';
import 'package:beldex_wallet/src/node/node_list.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';

Future defaultSettingsMigration(
    {required int version,
      required SharedPreferences sharedPreferences,
      required Box<Node> nodes}) async {
  final currentVersion =
      sharedPreferences.getInt('current_default_settings_migration_version') ??
          0;

  if (currentVersion >= version) {
    return;
  }

  final migrationVersionsLength = version - currentVersion;
  final migrationVersions = List<int>.generate(
      migrationVersionsLength, (i) => currentVersion + (i + 1));

  await Future.forEach(migrationVersions, (int version) async {
    try {
      switch (version) {
        case 1:
          await sharedPreferences.setString(
              'current_fiat_currency', FiatCurrency.usd.toString());
          await sharedPreferences.setInt(
              'current_fee_priority', BeldexTransactionPriority.standard.raw);
          await sharedPreferences.setInt('current_balance_display_mode',
              BalanceDisplayMode.fullBalance.raw);
          await sharedPreferences.setBool('save_recipient_address', true);
          await sharedPreferences.setBool('enable_fiat_currency', true);
          await resetToDefault(nodes,false);
          await changeCurrentNodeToDefault(
              sharedPreferences: sharedPreferences, nodes: nodes);
          await sharedPreferences.setBool('node_initial_setup', true);

          break;
        case 2:
          await replaceNodesMigration(nodes: nodes);
          await replaceDefaultNode(
              sharedPreferences: sharedPreferences, nodes: nodes);

          break;
        default:
          break;
      }

      await sharedPreferences.setInt(
          'current_default_settings_migration_version', version);
    } catch (e) {
      print('Migration error: ${e.toString()}');
    }
  });

  await sharedPreferences.setInt(
      'current_default_settings_migration_version', version);
}

Future<void> replaceNodesMigration({required Box<Node> nodes}) async {
  final replaceNodes = <String, Node>{};

  nodes.values.forEach((Node node) async {
    final nodeToReplace = replaceNodes[node.uri];

    if (nodeToReplace != null) {
      node.uri = nodeToReplace.uri;
      node.login = nodeToReplace.login;
      node.password = nodeToReplace.password;
      await node.save();
    }
  });
}

Future<void> changeCurrentNodeToDefault(
    {required SharedPreferences sharedPreferences,
      required Box<Node> nodes}) async {
  final timeZone = DateTime.now().timeZoneOffset.inHours;
  late String nodeUri;

  if (timeZone >= 1) { // Eurasia
    final _random = Random();
    final element = nodes.values.elementAt(_random.nextInt(nodes.length));
    print('nodeId 0 -> ${element.uri.toString()}');
    nodeUri = element.uri;
  } else { // America
    nodeUri = 'publicnode1.rpcnode.stream:29095';
  }

  final node = nodes.values.firstWhere((Node node) => node.uri == nodeUri,orElse: () => nodes.values.first);

  await sharedPreferences.setInt('current_node_id', node.key as int);
}

Future<void> replaceDefaultNode(
    {required SharedPreferences sharedPreferences,
      required Box<Node> nodes}) async {
  const nodesForReplace = <String>[];
  Node? currentNode;
  final currentNodeId = sharedPreferences.getInt('current_node_id');
  try {
    currentNode = nodes.values.firstWhere((Node node) =>
    node.key == currentNodeId);
  }catch (_) {}
  if (currentNode == null || nodesForReplace.contains(currentNode.uri)) {
    await changeCurrentNodeToDefault(
        sharedPreferences: sharedPreferences, nodes: nodes);
  }
}