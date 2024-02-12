import 'package:beldex_wallet/src/swap/model/create_transaction_model.dart';

import '../api_service/create_transaction_api_service.dart';

class CreateTransactionApiClient{
  late CreateTransactionModel? data;
  CreateTransactionApiService services = CreateTransactionApiService();

  Future<CreateTransactionModel?> createTransactionData(context, Map<String, String> params) async {
    data = await services.getSignature(params);
    return data;
  }
}