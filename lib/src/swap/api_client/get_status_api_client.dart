import 'package:beldex_wallet/src/swap/api_service/get_status_api_service.dart';
import 'package:beldex_wallet/src/swap/model/get_status_model.dart';

class GetStatusApiClient{
  late GetStatusModel? data;
  GetStatusApiService services = GetStatusApiService();

  Future<GetStatusModel?> getStatusData(context, Map<String, String> params) async {
    data = await services.getSignature(params);
    return data;
  }
}