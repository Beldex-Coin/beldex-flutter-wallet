class CoinInfo {
  CoinInfo({
    required this.name,
    this.ticker,
    required this.fullName,
    this.enabled = false,
    this.enabledFrom = false,
    this.enabledTo = false,
    this.fixRateEnabled = false,
    this.payinConfirmations = 0,
    this.extraIdName,
    this.logoUrl,
    this.protocol,
    this.network = '',
    this.precisionDecimals = 8,
    this.contractAddress,
    this.blockchain,
    this.transactionUrl,
  });

  final String name;
  final String? ticker;
  final String fullName;
  final bool enabled;
  final bool enabledFrom;
  final bool enabledTo;
  final bool fixRateEnabled;
  final int payinConfirmations;
  final String? extraIdName;
  final String? logoUrl;
  final String? protocol;
  final String network;
  final int precisionDecimals;
  final String? contractAddress;
  final String? blockchain;
  final String? transactionUrl;

  String get displayName => network.isNotEmpty ? '$fullName ($network)' : fullName;
  String? get image => logoUrl;
}
