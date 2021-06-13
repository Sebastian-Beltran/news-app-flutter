import 'dart:convert';

import 'package:flutter_bloc_architecture/src/model/api_response.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:http/http.dart' as http;

class MissingApiKeyException implements Exception{}
class ApiKeyInvalidException implements Exception{}

class NewsProvider{
  static const String _apiKey = '2e0689b80b714936ac2463ecb0004f31';
  static const String _baseURL = 'newsapi.org';
  static const String _topHeadLines = '/v2/top-headlines';

  final http.Client _httpClient;

  NewsProvider({http.Client? httpClient})
    : _httpClient=httpClient ?? http.Client();

  
  Future<List<Article>> topHeadLines(String country) async{
    final result = await _callGetaPI(
      endpoint: _topHeadLines, 
      params: {
        'country': country,
        'apiKey': _apiKey
      },
    );
    return result.articles!;
  }


  Future<ApiResponse> _callGetaPI({
    required String endpoint,
    required Map<String, String> params,

  }) async{
    var uri = Uri.https(_baseURL, endpoint,params);

    final response = await _httpClient.get(uri);
    final result = ApiResponse.fromJson(json.decode(response.body));

    if(result.status == 'error'){
      if(result.code == 'apiKeyMissing') throw MissingApiKeyException();
      if(result.code == 'apiKeyInvalid') throw ApiKeyInvalidException();
      throw Exception();
    }
    return result;

  }

}

