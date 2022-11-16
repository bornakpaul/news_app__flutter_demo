import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:news_app_demo/workflow/home_model/api.dart';

class ApiClient {
  static const _baseApiPath = "https://newsapi.org/v2/";
  static const _apiKey = "062365b4596547839841d22e451242d2";

  static Uri _uri(String route) =>
      Uri.parse('$_baseApiPath$route&apiKey=$_apiKey');

  static Future<dynamic> get(String route) async {
    final response = await http.get(_uri(route));
    return _handleApiResponse(response);
  }

  static dynamic _handleApiResponse(http.Response response) {
    final statusCode = response.statusCode;
    developer.log(
      'Api response: Status Code: $statusCode, Body: ${response.body}',
    );
    if (statusCode == 200) {
      return jsonDecode(response.body);
    } else if (statusCode > 200 && statusCode < 300) {
      return null;
    } else if (statusCode == 401) {
      throw ServerException('Request unauthorized');
    } else {
      final message = _getErrorMessage(response);
      throw ServerException(message);
    }
  }

  static String _getErrorMessage(http.Response response) {
    try {
      return NewsServerError.fromJson(jsonDecode(response.body)).message;
    } catch (e) {
      developer.log('unable to parse server error $e');
      return 'Something went wrong!';
    }
  }
}

class ServerException implements Exception {
  String message;

  ServerException(this.message);
}
