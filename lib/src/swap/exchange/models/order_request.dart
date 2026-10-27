class OrderRequest {
  OrderRequest({
    required this.fromCurrency,
    required this.fromNetwork,
    required this.toCurrency,
    required this.toNetwork,
    required this.destinationAddress,
    required this.depositAmount,
    this.destinationAddressMemo,
    this.refundAddress,
    this.refundAddressMemo,
    this.rate,
    this.networkFee,
    this.rateMode = 'FLOATING',
    this.markup,
  });

  final String fromCurrency;
  final String fromNetwork;
  final String toCurrency;
  final String toNetwork;
  final String destinationAddress;
  final String? destinationAddressMemo;
  final String? refundAddress;
  final String? refundAddressMemo;
  final String depositAmount;
  final String? rate;
  final String? networkFee;
  final String rateMode;
  final String? markup;
}
