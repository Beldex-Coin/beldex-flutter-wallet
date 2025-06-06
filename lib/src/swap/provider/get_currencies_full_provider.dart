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
    if(_disposed) return ;
    notifyListeners();
  }

  void setBdxIsEnabled(status){
    this.bdxIsEnabled = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getBdxIsEnabled(){
    return this.bdxIsEnabled;
  }

  void setSelectedYouGetCoins(youGetCoins){
    this.selectedYouGetCoins = youGetCoins;
    if(_disposed) return ;
    notifyListeners();
  }

  Coins getSelectedYouGetCoins(){
    return this.selectedYouGetCoins;
  }

  void setSelectedYouSendCoins(youSendCoins){
    this.selectedYouSendCoins = youSendCoins;
    if(_disposed) return ;
    notifyListeners();
  }

  Coins getSelectedYouSendCoins(){
    return this.selectedYouSendCoins;
  }

  void setSendCoinsDropDownVisible(status){
    this.youSendCoinsDropDownVisible = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getSendCoinsDropDownVisible(){
    return this.youSendCoinsDropDownVisible;
  }

  void setGetCoinsDropDownVisible(status){
    this.youGetCoinsDropDownVisible = status;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getGetCoinsDropDownVisible(){
    return this.youGetCoinsDropDownVisible;
  }

  @override
  void dispose() {
    try {
      this._disposed = true;
      super.dispose();
    } catch(ex) {
      print("Exception-> $ex");
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}