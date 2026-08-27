class QuickexRate {
  QuickexRate({
    required this.price,
    this.amountToGet,
    this.amountToGive,
    this.updatedAt,
    this.finalNetworkFeeAmount,
    this.minDepositAmount,
    this.maxDepositAmount,
  });

  factory QuickexRate.fromJson(Map<String, dynamic> json) {
    return QuickexRate(
      price: json['price']?.toString() ?? '0',
      amountToGet: json['amountToGet']?.toString(),
      amountToGive: json['amountToGive']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
      finalNetworkFeeAmount: json['finalNetworkFeeAmount']?.toString(),
      minDepositAmount: json['generalMinAmount']?.toString(),
      maxDepositAmount: json['generalMaxAmount']?.toString(),
    );
  }

  final String price;
  final String? amountToGet;
  final String? amountToGive;
  final String? updatedAt;
  final String? finalNetworkFeeAmount;
  final String? minDepositAmount;
  final String? maxDepositAmount;
}
