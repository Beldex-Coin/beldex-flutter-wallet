import 'package:beldex_wallet/src/swap/api_service/get_exchange_amount_api_service.dart';
import 'package:beldex_wallet/src/swap/model/get_exchange_amount_model.dart';

class GetExchangeAmountApiClient {
  late GetExchangeAmountModel? data;
  GetExchangeAmountApiService services = GetExchangeAmountApiService();

  Future<GetExchangeAmountModel?> getExchangeAmountData(context, Map<String?, String?> params) async {
    data = await services.getSignature(params);
    return data;
  }
}