class PairParams {
  PairParams({
    required this.fromCurrency,
    required this.toCurrency,
    this.minAmountFloat = '0',
    this.maxAmountFloat = '0',
    this.minAmountFixed = '0',
    this.maxAmountFixed = '0',
  });

  final String fromCurrency;
  final String toCurrency;
  final String minAmountFloat;
  final String maxAmountFloat;
  final String minAmountFixed;
  final String maxAmountFixed;
}
