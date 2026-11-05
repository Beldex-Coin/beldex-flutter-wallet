class SwapTransactionItemModel {

  SwapTransactionItemModel({
    required this.transactionId,
    required this.isPrivacySwap,
  });

  factory SwapTransactionItemModel.fromJson(Map<String, dynamic> json) {
    return SwapTransactionItemModel(
      transactionId: json['transactionId'],
      isPrivacySwap: json['isPrivacySwap'] ?? false,
    );
  }
  final String transactionId;
  final bool isPrivacySwap;
}