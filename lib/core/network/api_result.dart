import 'package:dio/dio.dart';
import 'api_error.dart';

/// Represents the base class for handling API results generically.
abstract class ApiResult<T> {
  static const String _jsonNodeData = "data";
  static const String _jsonNodeStatus = "status";
  static const String _jsonNodeStatusCode = "statusCode";


  /// Returns an empty mapper function.
  static Function(Map<String, dynamic>) get emptyMapper =>
          (Map<String, dynamic> d) => {};


  /// Converts a Dio [response] to an [ApiResult] using the provided [mapper].
  static ApiResult<T> fromResponse<T>(
      Response response,
      T Function(Map<String, dynamic>) mapper,
      ) {
    final responseData = response.data;

    bool correctResponse = (responseData is Map &&
        isCorrectResponse(responseData[_jsonNodeStatus])) ||
        isCorrectResponse(responseData[_jsonNodeStatusCode]) ||
        (responseData["success"] as bool? ?? false);

    if (!correctResponse) {
      return ServerError.fromResponse(response);
    } else if (correctResponse && responseData[_jsonNodeData] != null) {
      if (response.data[_jsonNodeData] is Map<String, dynamic>) {
        var responseMap =
        (response.data[_jsonNodeData] as Map<String, dynamic>);
        return Success(mapper(responseMap), isEmptyData: responseMap.isEmpty);
      } else {
        return Success(mapper(responseData));
      }
    } else {
      return InternalError(null);
    }
  }


  /// Converts a Dio [response] to an [ApiResult] of a List using the provided [mapper].
  static ApiResult<List<T>> fromListResponse<T>(
      Response response,
      T Function(Map<String, dynamic>) mapper,
      ) {
    final responseData = response.data;

    bool correctResponse = isCorrectResponse(responseData[_jsonNodeStatus]) ||
        isCorrectResponse(responseData[_jsonNodeStatusCode]);

    if (!correctResponse) {
      return ServerError.fromResponse(response);
    } else if (correctResponse && responseData[_jsonNodeData] != null) {
      var l = <T>[];
      if (response.data[_jsonNodeData] is List) {
        var rList = response.data[_jsonNodeData];
        for (var d in rList) {
          l.add(mapper(d));
        }
      }
      return Success(l);
    } else {
      return InternalError(null);
    }
  }


  /// Validates if the [responseCode] represents a successful HTTP status.
  static bool isCorrectResponse(dynamic responseCode) =>
      responseCode == 200 || responseCode == 201;


  /// Parses a raw JSON list into an [ApiResult] of type List<T>.
  static ApiResult<List<T>> fromRawJsonList<T>(
      dynamic data,
      T Function(Map<String, dynamic>) mapper,
      ) {
    try {
      if (data is List) {
        final list = data.map((item) => mapper(item)).toList();
        return Success(list);
      } else {
        return InternalError("Expected a list but got: ${data.runtimeType}");
      }
    } catch (e) {
      return InternalError("Parsing error: $e");
    }
  }
}


/// Represents a successful API response with data.
class Success<T> extends ApiResult<T> {
  final T data;
  final bool isEmptyData;

  Success(this.data, {this.isEmptyData = false});
}


/// Represents a failed API response with an [ApiError].
class Failed<T> extends ApiResult<T> {
  ApiError errors;

  Failed(this.errors);
}


/// Represents a server-side error derived from the response.
class ServerError<T> extends Failed<T> {
  ServerError(ApiError errors) : super(errors);

  /// Creates a [ServerError] from a Dio [response].
  static ServerError<T> fromResponse<T>(Response response) {
    return ServerError(ApiError.fromJson(response.data));
  }
}


/// Represents an internal error, usually during parsing or unexpected issues.
class InternalError<T> extends ApiResult<T> {
  final String? msg;

  InternalError(this.msg);
}


/// Represents a token expiration case.
class TokenExpired<T> extends ApiResult<T> {
  TokenExpired();
}


/// Represents an intentionally empty response.
class EmptyResponse<T> extends ApiResult<T> {
  EmptyResponse();
}
