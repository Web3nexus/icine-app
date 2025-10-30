
import 'package:icine/constants/method.dart';
import 'package:icine/core/utils/url_container.dart';
import 'package:icine/data/services/api_service.dart';

class CategoryRepo{

  ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<dynamic>getCategory(int page)async{
   String url='${UrlContainer.baseUrl}${UrlContainer.categoryEndPoint}?page=$page';
   final response = await apiClient.request(url, Method.getMethod, null);
   return response;
  }




}