import 'package:dio/dio.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/model/source_response.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2/";
  final String API_KEY = "14c2bcdb7a84479ca1e5e57d1c4ccce7";

  final Dio _dio = Dio();
  var getSourceUrl = "$mainUrl/sources";
  var getTopHeadlinesUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  Future<SourceResponse> getSources() async {
    var params = {"apiKey": API_KEY, "language": "en", "country": "us"};
    try {
      Response response = await _dio.get(getSourceUrl, queryParameters: params);

      return SourceResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception aa gaya hai: $error stacktrace : $stackTrace");
      return SourceResponse.withError(error);
    }
  }

  Future<ArticleResponse> getTopHeadLines() async {
    var param = {"apiKey": API_KEY, "country": "us"};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: param);

      return ArticleResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception aa gaya hai: $error stacktrace : $stackTrace");
      return ArticleResponse.withError(error);
    }
  }

  Future<ArticleResponse> getHotNews() async {
    var param = {"apiKey": API_KEY, "q": "apple", "sortBy": "popularity"};
    try {
      Response response = await _dio.get(everythingUrl, queryParameters: param);

      return ArticleResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception aa gaya hai: $error stacktrace : $stackTrace");
      return ArticleResponse.withError(error);
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var param = {
      "apiKey": API_KEY,
      "sources": sourceId,
    };
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: param);

      return ArticleResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception aa gaya hai: $error stacktrace : $stackTrace");
      return ArticleResponse.withError(error);
    }
  }

  Future<ArticleResponse> search(String searchValue) async {
    var param = {"apiKey": API_KEY, "q": searchValue};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: param);


      return ArticleResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception aa gaya hai: $error stacktrace : $stackTrace");
      return ArticleResponse.withError(error);
    }
  }
}
