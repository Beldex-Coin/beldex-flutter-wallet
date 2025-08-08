import 'package:flutter/cupertino.dart';

class ValidateExtraIdFieldProvider with ChangeNotifier {
  bool _disposed = false;
  String errorMessage = '';
  bool showMemo = false;
  bool showErrorBorder = false;

  void setErrorMessage(message){
    this.errorMessage = message;
    if(_disposed) return ;
    notifyListeners();
  }

  String getErrorMessage(){
    return this.errorMessage;
  }

  void setShowMemo(showMemo){
    this.showMemo = showMemo;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getShowMemo(){
    return this.showMemo;
  }

  void setShowErrorBorder(show){
    this.showErrorBorder = show;
    if(_disposed) return ;
    notifyListeners();
  }

  bool getShowErrorBorder(){
    return this.showErrorBorder;
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