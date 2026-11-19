import 'package:beldex_wallet/l10n.dart';
import 'package:flutter/material.dart';

import '../../util/generate_name.dart';

/// Maps a raw swap transaction status (as returned by the exchange and stored
/// in the swap history model's `txnStatus` field) to a localized label.
String swapStatusLabel(BuildContext context, String status) {
  final t = tr(context);
  switch (status) {
    case 'new':
      return t.swap_status_new;
    case 'waiting':
      return t.swap_status_waiting;
    case 'confirming':
      return t.swap_status_confirming;
    case 'exchanging':
      return t.swap_exchanging;
    case 'sending':
      return t.sending;
    case 'finished':
      return t.swap_completed;
    case 'refunded':
      return t.swap_status_refunded;
    case 'overdue':
      return t.swap_overdue;
    case 'expired':
      return t.swap_expired;
    case 'failed':
      return t.swap_failed;
    default:
      return status.isEmpty ? status : status.capitalized();
  }
}

/// Displays a swap transaction status with its localized label.
class SwapStatusLabel extends StatelessWidget {
  const SwapStatusLabel(this.status, {super.key, this.style, this.textAlign});

  final String status;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      swapStatusLabel(context, status),
      style: style,
      textAlign: textAlign,
    );
  }
}
