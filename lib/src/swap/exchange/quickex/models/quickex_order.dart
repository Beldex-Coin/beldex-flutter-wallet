class QuickexOrder {
  QuickexOrder({
    this.orderId,
    this.state = 'created',
    this.completed = false,
    this.depositAddress,
    this.depositAddressMemo,
    this.destinationAddress,
    this.destinationAddressMemo,
    this.claimedDepositAmount,
    this.amountToGet,
    this.fromCurrency,
    this.fromNetwork,
    this.toCurrency,
    this.toNetwork,
    this.txId,
    this.networkFee,
    this.createdAt,
    this.updatedAt,
    this.trackUrl,
    this.platformFeeAbsolute,
    this.claimedNetworkFee,
    this.minConfirmationsToTrade
  });

  factory QuickexOrder.fromJson(Map<String, dynamic> json) {
    final depositAddressObj = json['depositAddress'] as Map<String, dynamic>?;
    final pair = json['pair'] as Map<String, dynamic>?;
    final instrumentFrom = pair?['instrumentFrom'] as Map<String, dynamic>?;
    final instrumentTo = pair?['instrumentTo'] as Map<String, dynamic>?;
    final claimedPublicRateObj = json['claimedPublicRate'] as Map<String, dynamic>?;

    return QuickexOrder(
      orderId: _parseInt(json['orderId']),
      state: json['state']?.toString() ?? 'created',
      completed: json['completed'] ?? false,
      depositAddress: depositAddressObj?['depositAddress']?.toString(),
      depositAddressMemo: depositAddressObj?['depositAddressMemo']?.toString(),
      destinationAddress: json['destinationAddress']?.toString(),
      destinationAddressMemo: json['destinationAddressMemo']?.toString(),
      claimedDepositAmount: json['claimedDepositAmount']?.toString(),
      amountToGet: json['amountToGet']?.toString(),
      fromCurrency: instrumentFrom?['currencyTitle']?.toString(),
      fromNetwork: instrumentFrom?['networkTitle']?.toString(),
      toCurrency: instrumentTo?['currencyTitle']?.toString(),
      toNetwork: instrumentTo?['networkTitle']?.toString(),
      txId: json['txId']?.toString(),
      networkFee: json['networkFee']?.toString(),
      claimedNetworkFee: json['claimedNetworkFee']?.toString(),
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
      trackUrl: json['trackUrl']?.toString(),
      platformFeeAbsolute: claimedPublicRateObj?['platformFee_Absolute']?.toString(),
      minConfirmationsToTrade: json['minConfirmationsToTrade']?.toString(),
    );
  }

  final int? orderId;
  final String state;
  final bool completed;
  final String? depositAddress;
  final String? depositAddressMemo;
  final String? destinationAddress;
  final String? destinationAddressMemo;
  final String? claimedDepositAmount;
  final String? amountToGet;
  final String? fromCurrency;
  final String? fromNetwork;
  final String? toCurrency;
  final String? toNetwork;
  final String? txId;
  final String? networkFee;
  final String? createdAt;
  final String? updatedAt;
  final String? trackUrl;
  final String? platformFeeAbsolute;
  final String? claimedNetworkFee;
  final String? minConfirmationsToTrade;


  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
