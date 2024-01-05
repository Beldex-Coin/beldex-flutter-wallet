import 'package:beldex_wallet/src/domain/common/enumerable_item.dart';

import '../../../../l10n.dart';

class BeldexTransactionPriority extends EnumerableItem<int> with Serializable<int> {
  const BeldexTransactionPriority({required String title, required int raw})
      : super(title: title, raw: raw);

  static const all = [
    BeldexTransactionPriority.slow,
    BeldexTransactionPriority.flash
  ];

  static const slow = BeldexTransactionPriority(title: 'Slow', raw: 1);
  static const flash = BeldexTransactionPriority(title: 'Flash', raw: 5);
  static const standard = flash;

  static BeldexTransactionPriority deserialize({required int raw}) {
    switch (raw) {
      case 1:
        return slow;
      case 5:
        return flash;
      default:
        return flash;
    }
  }

  @override
  String tgetTitle(AppLocalizations l10n) {
    switch (this) {
      case BeldexTransactionPriority.slow:
        return l10n.transaction_priority_slow;
      case BeldexTransactionPriority.flash:
        return l10n.transaction_priority_blink;
      default:
        return '';
    }
  }
}
