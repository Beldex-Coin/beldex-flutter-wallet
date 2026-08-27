class OrderInfo {
  OrderInfo({
    required this.orderId,
    this.type = 'float',
    this.networkFee,
    this.platformFee,
    this.apiExtraFee,
    this.payinAddress,
    this.payinExtraId,
    this.payoutAddress,
    this.payoutExtraId,
    this.refundAddress,
    this.refundExtraId,
    this.amountExpectedFrom,
    this.amountExpectedTo,
    this.amountTo,
    this.status,
    this.currencyFrom,
    this.currencyTo,
    this.payTill,
    this.createdAt,
    this.payinConfirmations,
    this.rawResponse
  });

  final dynamic orderId;
  final String type;
  final String? networkFee;
  final String? platformFee;
  final String? apiExtraFee;
  final String? payinAddress;
  final String? payinExtraId;
  final String? payoutAddress;
  final String? payoutExtraId;
  final String? refundAddress;
  final String? refundExtraId;
  final String? amountExpectedFrom;
  final String? amountExpectedTo;
  final String? amountTo;
  final String? status;
  final String? currencyFrom;
  final String? currencyTo;
  final String? payTill;
  final int? createdAt;
  final dynamic payinConfirmations;
  final dynamic rawResponse;
}
