
import 'package:icine/constants/method.dart';
import 'package:icine/core/utils/url_container.dart';
import 'package:icine/data/services/api_service.dart';

class MyWatchHistoryRepo{

  ApiClient apiClient;
  MyWatchHistoryRepo({required this.apiClient});

  Future<dynamic>getWatchHistory(int page)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.watchHistoryEndPoint}?page=$page';
    final response= await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;
  }

}