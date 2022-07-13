import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/domain/common/enumerable_item.dart';

class BeldexTransactionPriority extends EnumerableItem<int> with Serializable<int> {
  const BeldexTransactionPriority({String title, int raw})
      : super(title: title, raw: raw);

  static const all = [
    BeldexTransactionPriority.slow,
    BeldexTransactionPriority.flash
  ];

  static const slow = BeldexTransactionPriority(title: 'Slow', raw: 1);
  static const flash = BeldexTransactionPriority(title: 'Flash', raw: 5);
  static const standard = flash;

  static BeldexTransactionPriority deserialize({int raw}) {
    switch (raw) {
      case 1:
        return slow;
      case 5:
        return flash;
      default:
        return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case BeldexTransactionPriority.slow:
        return S.current.transaction_priority_slow;
      case BeldexTransactionPriority.flash:
        return S.current.transaction_priority_blink;
      default:
        return '';
    }
  }
}
