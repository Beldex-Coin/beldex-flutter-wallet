import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:beldex_wallet/devtools.dart';
import 'package:beldex_wallet/src/node/node.dart';
import 'package:yaml/yaml.dart';

Future<List<Node>> loadDefaultNodes() async {
  final nodeListFileName = //'node_list.yml'; //'testnet_node_list.yml';
      isTestnet ? 'testnet_node_list.yml' : 'node_list.yml';
  final nodesRaw = await rootBundle.loadString('assets/$nodeListFileName');
  final nodes = loadYaml(nodesRaw) as YamlList;

  return nodes.map((dynamic raw) {
    if (raw is Map) {
      return Node.fromMap(raw);
    }

    return null;
  }).toList();
}

Future resetToDefault(Box<Node> nodeSource) async {
  final nodes = await loadDefaultNodes();
  final entities = <int, Node>{};

  await nodeSource.clear();

  for (var i = 0; i < nodes.length; i++) {
    entities[i] = nodes[i];
  }

  await nodeSource.putAll(entities);
}
