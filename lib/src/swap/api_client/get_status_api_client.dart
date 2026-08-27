import 'package:beldex_wallet/src/swap/api_service/get_status_api_service.dart';
import 'package:beldex_wallet/src/swap/exchange/quickex/quickex_api_service.dart';
import 'package:beldex_wallet/src/swap/model/get_status_model.dart';

class GetStatusApiClient{
  late GetStatusModel? data;
  GetStatusApiService services = GetStatusApiService();
  QuickexApiService _quickexApi = QuickexApiService();
  bool _isVisibleQRCodeDialog = false;
  bool get isVisibleQRCodeDialog => _isVisibleQRCodeDialog;

  Future<GetStatusModel?> getStatusData(context, Map<String, String> params, {String exchangeName = 'changelly'}) async {
    if (exchangeName == 'quickex') {
      final orderId = int.tryParse(params['id'] ?? '');
      if (orderId == null) return null;
      final order = await _quickexApi.getOrderInfo(orderId);
      if (order == null) return null;
      return GetStatusModel(
        result: order.state,
        id: orderId.toString(),
      );
    }
    data = await services.getSignature(params);
    return data;
  }

  void setQRCodeDialogVisibility(bool isVisible) {
    this._isVisibleQRCodeDialog = isVisible;
  }
}