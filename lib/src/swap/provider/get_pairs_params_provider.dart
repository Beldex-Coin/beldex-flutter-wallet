import 'package:beldex_wallet/src/swap/api_service/get_pairs_params_api_service.dart';
import 'package:beldex_wallet/src/swap/model/get_pairs_params_model.dart';
import 'package:flutter/cupertino.dart';

class GetPairsParamsProvider with ChangeNotifier {
  late GetPairsParamsModel? data;

  bool loading = false;
  bool _disposed = false;
  double minimumAmount = 0.0;
  double maximumAmount = 0.0;
  double sendAmountValue = 0.1;
  double getAmountValue = 0;
  bool errorState = false;
  bool sendCoinAvailableOnGetCoinStatus = false;
  bool getCoinAvailableOnSendCoinStatus = false;
  GetPairsParamsApiService services = GetPairsParamsApiService();

  void getPairsParamsData(context, List<Map<String, String>> params) async {
    loading = true;
    data = await services.getSignature(params);
    loading = false;

    notifyListeners();
  }

  void setSendValueMinimumAmountAndSendValueMaximumAmount(minimumAmount,maximumAmount){
    this.minimumAmount = minimumAmount;
    this.maximumAmount = maximumAmount;
    notifyListeners();
  }

  double getSendValueMinimumAmount(){
    return this.minimumAmount;
  }

  double getSendValueMaximumAmount(){
    return this.maximumAmount;
  }

  void setSendAmountValue(value){
    this.sendAmountValue = value;
    notifyListeners();
  }

  double getSendAmountValue(){
    return sendAmountValue;
  }

  void setGetAmountValue(value){
    this.getAmountValue = value;
    notifyListeners();
  }

  double getGetAmountValue(){
    return this.getAmountValue;
  }

  void setSendFieldErrorState(state){
    this.errorState = state;
    notifyListeners();
  }

  bool getSendFieldErrorState(){
    return this.errorState;
  }

  void setSendCoinAvailableOnGetCoinStatus(status){
    this.sendCoinAvailableOnGetCoinStatus = status;
    notifyListeners();
  }

  bool getSendCoinAvailableOnGetCoinStatus(){
    return this.sendCoinAvailableOnGetCoinStatus;
  }

  void setGetCoinAvailableOnSendCoinStatus(status){
    this.getCoinAvailableOnSendCoinStatus = status;
    notifyListeners();
  }

  bool getGetCoinAvailableOnSendCoinStatus(){
    return this.getCoinAvailableOnSendCoinStatus;
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