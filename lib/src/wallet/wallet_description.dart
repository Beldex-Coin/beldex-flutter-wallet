import 'package:beldex_wallet/src/wallet/wallet_type.dart';

class WalletDescription {
  WalletDescription({this.name, this.type});
  
  final String name;
  final WalletType type;
}