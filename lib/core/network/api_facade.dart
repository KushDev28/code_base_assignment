import 'package:codebase_assignment/core/di/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'api_config.dart';


/// A singleton class that abstracts and manages all HTTP API calls using Dio.
class ApiFacade {
  static final ApiFacade _instance = ApiFacade._internal();
  late final Dio _dio;
  late final ApiConfig _config;

  /// Returns the single instance of [ApiFacade].
  factory ApiFacade() {
    return _instance;
  }

  /// Private constructor to initialize Dio with config and logging.
  ApiFacade._internal() {
    _config = getIt<ApiConfig>();
    _dio = Dio(
      BaseOptions(
        baseUrl: _config.baseUrl,
        connectTimeout: _config.connectTimeout,
        receiveTimeout: _config.receiveTimeout,
        headers: _config.defaultHeaders,
      ),
    );
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  /// Sends a DELETE request to the given [endpoint] with optional [data].
  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioException catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  /// Sends a GET request to the given [endpoint] with optional [queryParams], [data], and [options].
  /// Automatically attaches the access token if [needAccessToken] is true.
  Future<Response> get(
      String endpoint, {
        Map<String, dynamic>? queryParams,
        bool needAccessToken = true,
        Map<String, dynamic>? data,
        Options? options,
      }) async {
    try {
      options ??= needAccessToken ? await _getAccessTokenOptions() : null;
      return await _dio.get(endpoint, queryParameters: queryParams, options: options, data: data);
    } on DioException catch (e) {
      if (e.response != null) {
        return _handleError(e);
      }
      rethrow;
    }
  }

  /// Sends a POST request to the given [endpoint] with optional [data].
  /// Automatically includes the access token if [needAccessToken] is true.
  Future<Response> post(String endpoint, {dynamic data, bool needAccessToken = true}) async {
    try {
      var options = needAccessToken ? await _getAccessTokenOptions() : null;
      return await _dio.post(endpoint, data: data, options: options);
    } on DioException catch (e) {
      if (e.response != null) {
        return _handleError(e);
      }
      rethrow;
    }
  }

  /// Sends a PUT request to the given [endpoint] with [data].
  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  /// Generates Dio [Options] with headers including access token from shared preferences.
  Future<Options> _getAccessTokenOptions() async {
    var r = _config.defaultHeaders;

    return Options(headers: r);
  }

  /// Handles Dio error responses and logs them.
  Response<dynamic> _handleError(DioException e) {
    debugPrint("API ERROR :: ${e.response?.statusCode} - ${e.message}");
    return e.response!;
  }
}
