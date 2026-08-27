class QuickexPair {
  QuickexPair({
    this.minAmount,
    this.maxAmount,
  });

  factory QuickexPair.fromJson(Map<String, dynamic> json) {
    return QuickexPair(
      minAmount: json['generalMinAmount']?.toString(),
      maxAmount: json['generalMaxAmount']?.toString(),
    );
  }

  final String? minAmount;
  final String? maxAmount;
}

