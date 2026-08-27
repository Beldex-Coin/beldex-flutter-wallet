enum ExchangeProviderType {
  changelly,
  quickex,
}

extension ExchangeProviderTypeExtension on ExchangeProviderType {
  String get displayName {
    switch (this) {
      case ExchangeProviderType.changelly:
        return 'Changelly';
      case ExchangeProviderType.quickex:
        return 'Quickex';
    }
  }

  String get logoAsset {
    switch (this) {
      case ExchangeProviderType.changelly:
        return 'assets/images/swap/swap.svg';
      case ExchangeProviderType.quickex:
        return 'assets/images/swap/swap_icon.svg';
    }
  }
}
