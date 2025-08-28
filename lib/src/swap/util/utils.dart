import 'dart:convert';
import 'dart:io';

import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/platform_channel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'data_class.dart';
import 'package:path/path.dart' as p;

const swapTransactionsListKey = "swap_transaction_list";

String toStringAsFixed(String? amount) {
  if (amount == null || amount.trim().isEmpty) {
    return "0.0";
  }

  try {
    final double d = double.parse(amount);
    return d >= 1.00 ? d.toStringAsFixed(4) : d.toStringAsFixed(8);
  } catch (e) {
    return "0.0";
  }
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

Future<void> openUrl({required MethodChannel methodChannelPlatform, required String? url}) async => await methodChannelPlatform.invokeMethod("action_view",<String, dynamic>{
  'url': url,
});

Future<void> storeTransactionIds(String fileName, String key, dynamic transactionId) async {
  try {
    // Get the documents directory
    final dir = await getApplicationDocumentsDirectory();
    final filePath = p.join(dir.path, fileName);
    final file = File(filePath);

    // Ensure the directory exists
    if (!(await dir.exists())) {
      await dir.create(recursive: true);
    }

    Map<String, dynamic> data = {};

    // Check if the file exists
    if (await file.exists()) {
      final jsonString = await file.readAsString();
      if (jsonString.trim().isNotEmpty) {
        try {
          data = jsonDecode(jsonString);
        } catch (e) {
          print('Failed to parse JSON, initializing empty structure.');
        }
      }
    } else {
      await file.create();
    }

    // Add value to the array at the specified key
    if (data.containsKey(key) && data[key] is List) {
      data[key].add(transactionId);
    } else {
      data[key] = [transactionId];
    }
    // Encode the updated data back to JSON
    final updatedJsonString = jsonEncode(data);
    print(updatedJsonString);
    // Write back to file
    await file.writeAsString(updatedJsonString);
    print('Transaction id added successfully to "$key" in $fileName');
  } catch (e) {
    print('Error adding value to JSON: $e');
  }
}

Future<List<String>> getTransactionIds(String fileName, String key) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = p.join(dir.path, fileName);
    final file = File(filePath);

    // Ensure the directory exists
    if (!(await dir.exists())) {
      await dir.create(recursive: true);
    }

    if (!(await file.exists())) {
      print("File does not exist.");
      return [];
    }

    final jsonString = await file.readAsString();
    final Map<String, dynamic> data = jsonDecode(jsonString);

    if (data.containsKey(key) && data[key] is List) {
      final List<String> array = (data[key] as List).cast<String>();
      return array;
    } else {
      print("Key '$key' not found or is not a list.");
      return [];
    }
  } catch (e) {
    print("Error reading JSON: $e");
    return [];
  }
}

bool syncStatus(SyncStatus status) {
  return status is SyncedSyncStatus || status.blocksLeft == 0;
}

Coins btcCoin = Coins('BTC', 'Bitcoin', "", 'bitcoin', 'BTC');
Coins bdxCoin = Coins('BDX', 'Beldex', "", 'beldex', 'BDX');

Widget PairsWidget({required SettingsStore settingsStore, required String? from, required String? to}) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(bottom: 10, top: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: settingsStore.isDarkTheme ? Color(0xff333343) : Color(0xffffffff),
        borderRadius:BorderRadius.all(Radius.circular(6)),
        border: Border.all(
            color: Color(0xff00AD07)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            from?.toUpperCase() ?? "",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
          SizedBox(width: 5,),
          SvgPicture.asset(
            'assets/images/swap/swap_icon.svg',
            width: 12,
            height: 12,
          ),
          SizedBox(width: 5,),
          Text(
            to?.toUpperCase() ?? "",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800  ,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ],
      ),
    ),
  );
}

String networkWithUppercase(String? blockChain) {
  return (blockChain?.isNotEmpty ?? false)
      ? blockChain!.replaceAll("_", " ").toUpperCase()
      : "...";
}

Widget networkWidget(SettingsStore settingsStore, String? blockChain) {
  return Flexible(
    flex: 1,
    child: Container(
      margin: EdgeInsets.only(left: 3, top: 3, bottom: 3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: settingsStore.isDarkTheme
                ? Color(0xff4F4F70)
                : Color(0xffDADADA),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'NETWORK: ',
            style: TextStyle(
                color: settingsStore.isDarkTheme
                    ? Color(0xffAFAFBE)
                    : Color(0xff737373),
                fontSize: 14,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                  text: networkWithUppercase(blockChain),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff222222)))
            ]),
      ),
    ),
  );
}

Widget networkTextWidget(String? toBlockChain) {
  return Text('NETWORK: $toBlockChain',
      style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xff00AD07)));
}
