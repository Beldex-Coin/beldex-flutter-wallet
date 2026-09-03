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

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
    orderId: json['orderId'],
    type: json['type'] ?? 'float',
    networkFee: json['networkFee'],
    platformFee: json['platformFee'],
    apiExtraFee: json['apiExtraFee'],
    payinAddress: json['payinAddress'],
    payinExtraId: json['payinExtraId'],
    payoutAddress: json['payoutAddress'],
    payoutExtraId: json['payoutExtraId'],
    refundAddress: json['refundAddress'],
    refundExtraId: json['refundExtraId'],
    amountExpectedFrom: json['amountExpectedFrom'],
    amountExpectedTo: json['amountExpectedTo'],
    amountTo: json['amountTo'],
    status: json['status'],
    currencyFrom: json['currencyFrom'],
    currencyTo: json['currencyTo'],
    payTill: json['payTill'],
    createdAt: json['createdAt'],
    payinConfirmations: json['payinConfirmations'],
    rawResponse: json['raw_response'],
  );

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'type': type,
    'networkFee': networkFee,
    'platformFee': platformFee,
    'apiExtraFee': apiExtraFee,
    'payinAddress': payinAddress,
    'payinExtraId': payinExtraId,
    'payoutAddress': payoutAddress,
    'payoutExtraId': payoutExtraId,
    'refundAddress': refundAddress,
    'refundExtraId': refundExtraId,
    'amountExpectedFrom': amountExpectedFrom,
    'amountExpectedTo': amountExpectedTo,
    'amountTo': amountTo,
    'status': status,
    'currencyFrom': currencyFrom,
    'currencyTo': currencyTo,
    'payTill': payTill,
    'createdAt': createdAt,
    'payinConfirmations': payinConfirmations,
    'rawResponse': rawResponse,
  };
}
