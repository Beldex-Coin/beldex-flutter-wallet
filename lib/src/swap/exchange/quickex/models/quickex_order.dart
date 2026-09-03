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
    this.minConfirmationsToTrade,
    this.price,
    this.moneyReceived,
    this.moneySent,
    this.payinHash,
    this.payoutHashLink,
    this.payoutHash,
    this.payinExtraIdName,
    this.orderEvents = const [],
    this.failedToCreate = false,
    this.isPendingToCreate = false
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
      price: claimedPublicRateObj?['price']?.toString(),
      moneyReceived: json['moneyReceived']?.toString(),
      moneySent: json['moneySent']?.toString(),
      payinHash: json['payinHash']?.toString(),
      payoutHashLink: json['payoutHashLink']?.toString(),
      payoutHash: json['payoutHash']?.toString(),
      payinExtraIdName: json['payinExtraIdName']?.toString(),
      orderEvents: _parseOrderEvents(json['orderEvents']),
      failedToCreate: json['failedToCreate'] ?? false,
      isPendingToCreate: json['isPendingToCreate'] ?? false,
    );
  }

  static List<QuickexOrderEvent> _parseOrderEvents(dynamic value) {
    if (value is! List) return const [];
    return value
        .whereType<Map<String, dynamic>>()
        .map((e) => QuickexOrderEvent(
              kind: e['kind']?.toString() ?? '',
              createdAt: e['createdAt']?.toString(),
            ))
        .toList();
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
  final String? price;
  final String? moneyReceived;
  final String? moneySent;
  final String? payinHash;
  final String? payoutHashLink;
  final String? payoutHash;
  final String? payinExtraIdName;
  final List<QuickexOrderEvent> orderEvents;
  final bool failedToCreate;
  final bool isPendingToCreate;


  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class QuickexOrderEvent {
  QuickexOrderEvent({
    required this.kind,
    this.createdAt,
  });

  final String kind;
  final String? createdAt;
}
