
import 'package:icine/constants/method.dart';
import 'package:icine/core/utils/url_container.dart';
import 'package:icine/data/services/api_service.dart';

class WishListRepo{

  ApiClient apiClient;
  WishListRepo({required this.apiClient});

  Future<dynamic>getWishList(int page)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.wishlistEndPoint}?page=$page';
    final response=await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;
  }

  Future<dynamic>removeFromWishlist(int itemId,int episodeId)async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.removeFromWishlistEndPoint}episode_id=$episodeId&item_id=$itemId';
    final response=await apiClient.request(url, Method.postMethod, null,passHeader: true);
    return response;
  }

}