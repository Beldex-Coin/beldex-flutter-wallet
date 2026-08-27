class QuickexMinMaxHint {
  final String? from;
  final String? to;
  final String minAmountFloat;
  final String maxAmountFloat;
  final String minAmountFixed;

  QuickexMinMaxHint({
    this.from,
    this.to,
    this.minAmountFloat = '0',
    this.maxAmountFloat = '0',
    this.minAmountFixed = '0',
  });
}

class QuickexApiResult<T> {
  final bool success;
  final T? data;
  final String? method;
  final String? errorMessage;
  final QuickexMinMaxHint? minMaxHint;

  QuickexApiResult._({
    required this.success,
    this.data,
    this.method,
    this.errorMessage,
    this.minMaxHint,
  });

  factory QuickexApiResult.ok(T data, {String? method}) =>
      QuickexApiResult._(success: true, data: data, method: method);

  factory QuickexApiResult.error(String message, {String? method, QuickexMinMaxHint? minMaxHint}) =>
      QuickexApiResult._(success: false, errorMessage: message, method: method, minMaxHint: minMaxHint);
}
