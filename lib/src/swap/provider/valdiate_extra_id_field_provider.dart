import 'package:flutter/cupertino.dart';

class ValidateExtraIdFieldProvider with ChangeNotifier {
  bool _disposed = false;
  String errorMessage = '';
  bool showMemo = false;
  bool showErrorBorder = false;

  void setErrorMessage(message){
    this.errorMessage = message;
    notifyListeners();
  }

  String getErrorMessage(){
    return this.errorMessage;
  }

  void setShowMemo(showMemo){
    this.showMemo = showMemo;
    notifyListeners();
  }

  bool getShowMemo(){
    return this.showMemo;
  }

  void setShowErrorBorder(show){
    this.showErrorBorder = show;
    notifyListeners();
  }

  bool getShowErrorBorder(){
    return this.showErrorBorder;
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