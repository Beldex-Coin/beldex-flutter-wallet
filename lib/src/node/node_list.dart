import 'dart:io';

import 'package:beldex_wallet/src/util/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:beldex_wallet/devtools.dart';
import 'package:beldex_wallet/src/node/node.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yaml/yaml.dart';

Future<List<Node>> loadDefaultNodes() async {
  final nodeListFileName = isTestnet
      ? 'testnet_node_list.yml'
      : 'node_list.yml';
  print('nodeListFileName ---> $nodeListFileName');

  final nodesRaw = await rootBundle.loadString('assets/$nodeListFileName');
  final nodes = loadYaml(nodesRaw) as YamlList;

  final n = <Node>[];
  nodes.forEach((dynamic raw) {
    if (raw is Map) {
      n.add(Node.fromMap(raw));
    }
  });
  return n;
}

Future<List<Node>> loadRemoteNodes() async {
  final nodeListFileName = isTestnet
      ? 'testnet_node_list.yml'
      : 'node_list.yml';
  await downloadNodeListFile();
  var nodesRaw = await rootBundle.loadString('assets/$nodeListFileName');
  final dir = await getApplicationDocumentsDirectory();
  final nodesFilePath = '${dir.path}/$downloadNodeListFileName';
  final nodesFile = File(nodesFilePath);
  if (await nodesFile.exists()) {
    nodesRaw = nodesFile.readAsStringSync();
  } else {
    nodesRaw = await rootBundle.loadString('assets/$nodeListFileName');
  }
  final n = <Node>[];
  try {
    final nodes = loadYaml(nodesRaw) as YamlList;
    nodes.forEach((dynamic raw) {
      if (raw is Map) {
        n.add(Node.fromMap(raw));
      }
    });
  }catch(e){
    print('Load node yml file exception : $e');
  }
  return n;
}

Future resetToDefault(Box<Node> nodeSource,bool remoteNode) async {
  var nodes = <Node>[];
  if (remoteNode && !isTestnet) {
    nodes = await loadRemoteNodes();
  } else {
    nodes = await loadDefaultNodes();
  }
  final entities = <int, Node>{};

  await nodeSource.clear();

  for (var i = 0; i < nodes.length; i++) {
    entities[i] = nodes[i];
  }

  await nodeSource.putAll(entities);
}


Future downloadNodeListFile() async {
  final dio = Dio();
  final dir = await getApplicationDocumentsDirectory();
  final nodeFileDownloadPath = '${dir.path}/$downloadNodeListFileName';
  try {
    await dio.download(downloadNodeListUrl, nodeFileDownloadPath,
        onReceiveProgress: (received, total) {});
  } catch (e) {
    print('Download node yml file exception : $e');
  }
}
