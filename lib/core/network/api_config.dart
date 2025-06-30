import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiConfig {
  String get baseUrl;

  Duration get connectTimeout;

  Duration get receiveTimeout;

  Map<String, String> get defaultHeaders;
}

class DefaultApiConfig implements ApiConfig {
  @override
  String get baseUrl => dotenv.env['API_BASE_URL'] ?? 'https://fallback.url';

  /// Returns a connection timeout of 18 seconds.
  @override
  Duration get connectTimeout => const Duration(seconds: 18);

  /// Returns a receive timeout of 18 seconds.
  @override
  Duration get receiveTimeout => const Duration(seconds: 18);

  /// Returns a default header with content-type set to application/json.
  @override
  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'x-api-key': dotenv.env['API_KEY'] ?? '',
      };
}
