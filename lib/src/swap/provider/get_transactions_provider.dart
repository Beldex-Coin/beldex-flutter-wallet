import 'package:beldex_wallet/src/swap/api_service/get_transactions_api_service.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:flutter/cupertino.dart';

class GetTransactionsProvider with ChangeNotifier {
  late GetTransactionsModel? data;

  bool loading = true;
  bool _disposed = false;
  GetTransactionsApiService services = GetTransactionsApiService();

  void getTransactionsData(context, Map<String, String> params) async {
    loading = true;
    data = await services.getSignature(params);
    loading = false;

    notifyListeners();
  }

  void getTransactionsListData(context, Map<String, List<String>> params) async {
    loading = true;
    data = await services.getSignatureWithIds(params);
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