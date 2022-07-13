import 'package:flutter/foundation.dart';
import 'package:beldex_wallet/src/wallet/balance.dart';

class BelDexBalance extends Balance {
  BelDexBalance({@required this.fullBalance, @required this.unlockedBalance});

  final int fullBalance;
  final int unlockedBalance;
}
