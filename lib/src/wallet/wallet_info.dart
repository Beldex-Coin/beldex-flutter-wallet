import 'package:hive/hive.dart';
import 'package:beldex_wallet/src/wallet/wallet_type.dart';

part 'wallet_info.g.dart';

@HiveType(typeId: 4)
class WalletInfo extends HiveObject {
  WalletInfo(
      {this.id,
      this.name,
      this.type,
      this.isRecovery,
      this.restoreHeight,
      this.timestamp,
      this.hasTestnet = false});

  static const boxName = 'WalletInfo';

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  WalletType type;

  @HiveField(3)
  bool isRecovery;

  @HiveField(4)
  int restoreHeight;

  @HiveField(5)
  int timestamp;

  @HiveField(6)
  bool hasTestnet;

  DateTime get date => DateTime.fromMillisecondsSinceEpoch(timestamp);
}
