import 'package:get/get.dart';
import 'package:pinntag/api/api_services.dart';
import 'package:pinntag/home/model/switch_response_model.dart';
import 'package:pinntag/api/endpoints.dart';

class HomeRepo {
  final ApiService _apiService = Get.put(ApiService());

  Future<SwitchResponseModel> switchBusinessApi(String businessId) async {
    try {
      final response = await _apiService.request(
        path: '${Endpoints.switchBussiness}$businessId',
      );

      return SwitchResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
