import 'package:beldex_wallet/src/wallet/beldex/beldex_amount_format.dart';
import 'package:beldex_coin/beldex_coin_structs.dart';
import 'package:beldex_wallet/src/util/parseBoolFromString.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_direction.dart';
import 'package:beldex_wallet/src/domain/common/format_amount.dart';

class TransactionInfo {
  TransactionInfo(this.id, this.height, this.direction, this.date,
      this.isPending, this.amount, this.accountIndex, this.recipientAddress, //this.isStake
      );

  TransactionInfo.fromMap(Map map)
      : id = (map['hash'] ?? '') as String,
        height = (map['height'] ?? 0) as int,
        direction =
            parseTransactionDirectionFromNumber(map['direction'] as String) ??
                TransactionDirection.incoming,
        date = DateTime.fromMillisecondsSinceEpoch(
            (int.parse(map['timestamp'] as String) ?? 0) * 1000),
        isPending = parseBoolFromString(map['isPending'] as String),
       // isStake = parseBoolFromString(map['isStake'] as String),
        amount = map['amount'] as int,
        recipientAddress = (map['paymentId'] ?? '') as String,
        accountIndex = int.parse(map['accountIndex'] as String);

  TransactionInfo.fromRow(TransactionInfoRow row)
      : id = row.getHash(),
        height = row.blockHeight,
        direction = parseTransactionDirectionFromInt(row.direction) ??
            TransactionDirection.incoming,
        date = DateTime.fromMillisecondsSinceEpoch(row.getDatetime() * 1000),
        isPending = row.isPending != 0,
       // isStake = row.isStake != 0,
       recipientAddress = row.getPaymentId(),
        amount = row.getAmount(),
        accountIndex = row.subaddrAccount;

  final String id;
  final int height;
  final TransactionDirection direction;
  final DateTime date;
  final int accountIndex;
  final bool isPending;
 // final bool isStake;
  final int amount;
  String recipientAddress;

  String _fiatAmount;

  String amountFormatted() => '${belDexAmountToString(amount)} BDX';

  String fiatAmount() => _fiatAmount ?? '';

  void changeFiatAmount(String amount) => _fiatAmount = formatAmount(amount);
}
