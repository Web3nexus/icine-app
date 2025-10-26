import 'package:Icine/constants/method.dart';
import 'package:Icine/core/utils/url_container.dart';
import 'package:Icine/data/services/api_service.dart';

class HomeRepo{

  ApiClient apiClient;
  HomeRepo({required this.apiClient});


  Future<dynamic>getSlider()async{

    String url='${UrlContainer.baseUrl}${UrlContainer.movieSliderEndPoint}';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;

  }

  Future<dynamic>getLiveTv()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.liveTelevisionEndPoint}';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic>getFeaturedMovie()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.featuredMovieEndPoint}';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic>getPopUpAds()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.popUpAdsEndPoint}';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic>getRecentMovie()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.recentMovieEndPoint}';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic>getLatestSeries()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.latestSeriesEndPoint}';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic>getSingleBannerImage()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.singleBannerEndPoint}';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic>getTrailerMovie()async{
     String url='${UrlContainer.baseUrl}${UrlContainer.trailerMovieEndPoint}';
     final response=await apiClient.request(url, Method.getMethod, null);
     return response;
  }

  Future<dynamic>getFreeZoneMovie(int page)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.freeZoneEndPoint}?page=${page.toString()}';
    final response=await apiClient.request(url,Method.getMethod, null);
    return response;
  }


}