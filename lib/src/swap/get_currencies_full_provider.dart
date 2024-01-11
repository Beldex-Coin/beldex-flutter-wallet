import 'package:beldex_wallet/src/swap/model/get_currencies_full_model.dart';
import 'package:flutter/cupertino.dart';

import 'api_service/get_currencies_full_api_service.dart';

class GetCurrenciesFullProvider with ChangeNotifier {
  late GetCurrenciesFullModel? data;

  bool loading = false;
  bool bdxIsEnabled = false;
  GetCurrenciesFullApiService services = GetCurrenciesFullApiService();

  getCurrenciesFullData(context) async {
    loading = true;
    data = await services.getSignature();
    loading = false;

    notifyListeners();
  }

  setBdxIsEnabled(status){
    this.bdxIsEnabled = status;
    notifyListeners();
  }

  getBdxIsEnabled(){
    return this.bdxIsEnabled;
  }
}