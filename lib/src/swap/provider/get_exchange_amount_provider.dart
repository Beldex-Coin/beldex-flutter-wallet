import 'package:beldex_wallet/src/swap/api_service/get_exchange_amount_api_service.dart';
import 'package:flutter/cupertino.dart';
import '../model/get_exchange_amount_model.dart';

class GetExchangeAmountProvider with ChangeNotifier {
  late GetExchangeAmountModel? data;

  bool loading = true;
  bool _disposed = false;
  GetExchangeAmountApiService services = GetExchangeAmountApiService();

  void getExchangeAmountData(context, Map<String, String> params) async {
    loading = true;
    data = await services.getSignature(params);
    loading = false;

    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}