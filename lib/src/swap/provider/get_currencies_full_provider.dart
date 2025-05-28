import 'package:beldex_wallet/src/swap/model/get_currencies_full_model.dart';
import 'package:flutter/cupertino.dart';

import '../api_service/get_currencies_full_api_service.dart';
import '../util/data_class.dart';

class GetCurrenciesFullProvider with ChangeNotifier {
  late GetCurrenciesFullModel? data;

  bool loading = true;
  bool bdxIsEnabled = false;
  bool _disposed = false;
  Coins selectedYouSendCoins = Coins('BTC', 'Bitcoin', "", 'bitcoin', 'BTC');
  Coins selectedYouGetCoins = Coins('BDX', 'Beldex', "", 'beldex', 'BDX');
  bool youSendCoinsDropDownVisible = false;
  bool youGetCoinsDropDownVisible = false;
  GetCurrenciesFullApiService services = GetCurrenciesFullApiService();

  void getCurrenciesFullData(context) async {
    loading = true;
    data = await services.getSignature();
    loading = false;

    notifyListeners();
  }

  void setBdxIsEnabled(status){
    this.bdxIsEnabled = status;
    notifyListeners();
  }

  bool getBdxIsEnabled(){
    return this.bdxIsEnabled;
  }

  void setSelectedYouGetCoins(youGetCoins){
    this.selectedYouGetCoins = youGetCoins;
    notifyListeners();
  }

  Coins getSelectedYouGetCoins(){
    return this.selectedYouGetCoins;
  }

  void setSelectedYouSendCoins(youSendCoins){
    this.selectedYouSendCoins = youSendCoins;
    notifyListeners();
  }

  Coins getSelectedYouSendCoins(){
    return this.selectedYouSendCoins;
  }

  void setSendCoinsDropDownVisible(status){
    this.youSendCoinsDropDownVisible = status;
    notifyListeners();
  }

  bool getSendCoinsDropDownVisible(){
    return this.youSendCoinsDropDownVisible;
  }

  void setGetCoinsDropDownVisible(status){
    this.youGetCoinsDropDownVisible = status;
    notifyListeners();
  }

  bool getGetCoinsDropDownVisible(){
    return this.youGetCoinsDropDownVisible;
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