import '../../l10n.dart';

class AmountDetail {
  const AmountDetail(this.index, this.fraction);

  final int index;
  final int fraction;

  static const List<AmountDetail> all = [
    AmountDetail.ultra,
    AmountDetail.detailed,
    AmountDetail.normal,
    AmountDetail.none
  ];
  static const AmountDetail ultra = AmountDetail(0, 5);
  static const AmountDetail detailed = AmountDetail(1, 4);
  static const AmountDetail normal = AmountDetail(2, 2);
  static const AmountDetail none = AmountDetail(3, 0);

  static AmountDetail deserialize(int index) {
    return all.firstWhere((element) => element.index == index,
        orElse: () => AmountDetail.ultra);
  }

  @override
  String getTitle(AppLocalizations l10n)  {
    switch (index) {
      case (0):
        return l10n.fiveDecimals;
      case (1):
        return l10n.fourDecimals;
      case (2):
        return l10n.twoDecimals;
      case (3):
        return l10n.zeroDecimal;
      default:
        return '';
    }
  }
}

double cryptoAmountToDouble({required num amount, required num divider}) => amount / divider;

int doubleToCryptoAmount({required double amount, required num divider}) =>
    (amount * divider).toInt();

// Litecoin
const litecoinAmountDivider = 100000000;

double litecoinAmountToDouble({required int amount}) =>
    cryptoAmountToDouble(amount: amount, divider: litecoinAmountDivider);

// Ethereum
const ethereumAmountDivider = 1000000000000000000;

double ethereumAmountToDouble({required num amount}) =>
    cryptoAmountToDouble(amount: amount, divider: ethereumAmountDivider);

// Dash
const dashAmountDivider = 100000000;

double dashAmountToDouble({required int amount}) =>
    cryptoAmountToDouble(amount: amount, divider: dashAmountDivider);

// Bitcoin Cash
const bitcoinCashAmountDivider = 100000000;

double bitcoinCashAmountToDouble({required int amount}) =>
    cryptoAmountToDouble(amount: amount, divider: bitcoinCashAmountDivider);

// Bitcoin
const bitcoinAmountDivider = 100000000;

double bitcoinAmountToDouble({required int amount}) =>
    cryptoAmountToDouble(amount: amount, divider: bitcoinAmountDivider);
