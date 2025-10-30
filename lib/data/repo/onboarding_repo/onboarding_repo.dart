import 'package:icine/constants/method.dart';
import 'package:icine/core/utils/url_container.dart';
import 'package:icine/data/model/global/response_model/response_model.dart';
import 'package:icine/data/services/api_service.dart';

class OnboardingRepo {
  ApiClient apiClient;

  OnboardingRepo({required this.apiClient});

  Future<dynamic> getOnboardingData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.onboardingEndPoint}';
    ResponseModel model = await apiClient.request(url, Method.getMethod, null);
    return model;
  }
}
