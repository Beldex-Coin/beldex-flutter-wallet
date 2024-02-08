import 'package:beldex_wallet/src/swap/api_service/validate_address_api_service.dart';
import 'package:beldex_wallet/src/swap/model/validate_address_model.dart';
import 'package:flutter/cupertino.dart';

class ValidateAddressProvider with ChangeNotifier {
  late ValidateAddressModel? data;

  bool loading = true;
  bool _disposed = false;
  ValidateAddressApiService services = ValidateAddressApiService();
  String recipientAddress = '';
  bool successState = true;
  String errorMessage = '';

  void validateAddressData(context, Map<String, String> params) async {
    loading = true;
    data = await services.getSignature(params);
    loading = false;

    notifyListeners();
  }

  void setRecipientAddress(address){
    this.recipientAddress = address;
    notifyListeners();
  }

  String getRecipientAddress(){
    return this.recipientAddress;
  }

  void setSuccessState(state){
    this.successState = state;
    notifyListeners();
  }

  bool getSuccessState(){
    return this.successState;
  }

  void setErrorMessage(message){
    this.errorMessage = message;
    notifyListeners();
  }

  String getErrorMessage(){
    return this.errorMessage;
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