class QuickexInstrument {
  QuickexInstrument({
    required this.currencyTitle,
    required this.networkTitle,
    this.fullName = '',
    this.currencyFriendlyTitle = '',
    this.slug = '',
    this.precisionDecimals = 8,
    this.logoUrl = '',
    this.requiresMemo = false,
    this.instrumentType = 'crypto',
    this.bestChangeName = '',
    this.contractAddress = '',
  });

  factory QuickexInstrument.fromJson(Map<String, dynamic> json) {
    return QuickexInstrument(
      currencyTitle: json['currencyTitle']?.toString() ?? '',
      networkTitle: json['networkTitle']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      currencyFriendlyTitle: json['currencyFriendlyTitle']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      precisionDecimals: _parseInt(json['precisionDecimals']) ?? 8,
      logoUrl: json['currencyLogoLink']?.toString() ?? '',
      requiresMemo: json['requiresMemo'] ?? false,
      instrumentType: json['instrumentType']?.toString() ?? 'crypto',
      bestChangeName: json['bestChangeName']?.toString() ?? '',
      contractAddress: json['contractAddress']?.toString() ?? '',
    );
  }

  final String currencyTitle;
  final String networkTitle;
  final String fullName;
  final String currencyFriendlyTitle;
  final String slug;
  final int precisionDecimals;
  final String logoUrl;
  final bool requiresMemo;
  final String instrumentType;
  final String bestChangeName;
  final String contractAddress;

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
