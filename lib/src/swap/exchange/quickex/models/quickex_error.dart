class QuickexError {
  QuickexError({
    this.status,
    this.message,
    this.data,
  });

  factory QuickexError.fromJson(Map<String, dynamic> json) {
    return QuickexError(
      status: json['status']?.toString(),
      message: json['message']?.toString(),
      data: json['data'] is Map<String, dynamic>
          ? json['data'] as Map<String, dynamic>
          : null,
    );
  }

  final String? status;
  final String? message;
  final Map<String, dynamic>? data;

  String get errorMessage {
    final dataMessage = data?['address']?.toString() ??
        data?['localizedMessage']?.toString() ??
        '';
    return '$message${dataMessage.isNotEmpty ? ': $dataMessage' : ''}';
  }
}
