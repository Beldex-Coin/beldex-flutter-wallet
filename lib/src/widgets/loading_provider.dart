import 'package:flutter/foundation.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void showLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void hideLoader() {
    _isLoading = false;
    notifyListeners();
  }
}
