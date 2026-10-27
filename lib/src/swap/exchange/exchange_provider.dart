enum ExchangeProviderType {
  changelly,
  quickex,
}

extension ExchangeProviderTypeExtension on ExchangeProviderType {
  String get displayName {
    switch (this) {
      case ExchangeProviderType.changelly:
        return 'changelly';
      case ExchangeProviderType.quickex:
        return 'quickex';
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
