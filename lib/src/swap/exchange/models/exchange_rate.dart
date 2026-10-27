class ExchangeRate {
  ExchangeRate({
    required this.from,
    required this.to,
    required this.amountFrom,
    required this.amountTo,
    required this.rate,
    this.networkFee,
    this.minAmount,
    this.maxAmount,
    this.platformFee
  });

  final String from;
  final String to;
  final String amountFrom;
  final String amountTo;
  final String rate;
  final String? networkFee;
  final String? minAmount;
  final String? maxAmount;
  final String? platformFee;
}
