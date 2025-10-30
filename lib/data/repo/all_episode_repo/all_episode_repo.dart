import 'package:icine/constants/method.dart';
import 'package:icine/core/utils/url_container.dart';
import 'package:icine/data/services/api_service.dart';

class AllEpisodeRepo {
  ApiClient apiClient;

  AllEpisodeRepo({required this.apiClient});

  Future<dynamic>getEpisode(int page)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.allEpisodeEndPoint}$page';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }


}
