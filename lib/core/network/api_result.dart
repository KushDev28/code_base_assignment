import 'package:dio/dio.dart';
import 'api_error.dart';

/// Represents the base class for handling API results generically.
abstract class ApiResult<T> {}

/// Represents a successful API response with data.
class Success<T> extends ApiResult<T> {
  final T data;
  final bool isEmptyData;

  Success(this.data, {this.isEmptyData = false});
}

/// Represents a failed API response with an [ApiError].
class Failed<T> extends ApiResult<T> {
  final ApiError error;

  Failed(this.error);
}

/// Represents a server-side error derived from the response.
class ServerError<T> extends Failed<T> {
  ServerError(ApiError error) : super(error);

  factory ServerError.fromResponse(Response response) {
    return ServerError(ApiError.fromJson(response.data));
  }
}

/// Represents an internal error, usually during parsing or unexpected issues.
class InternalError<T> extends ApiResult<T> {
  final String? message;

  InternalError(this.message);
}
