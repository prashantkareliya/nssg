import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants({
    required this.endpoint,
    required this.apiKey,
  });

  factory Constants.of() {
    if (_instance != null) return _instance!;
    _instance = Constants._prd();
    return _instance!;
  }

  factory Constants._prd() {
    return const Constants(
      endpoint: 'http://122.170.107.160/nssg/',
      apiKey: '', //for use in future
    );
  }

  static Constants? _instance;

  final String endpoint;
  final String apiKey;
}

class ResponseStatus {
  static const String failed = "false";
  static const String success = "true";
}

class ApiEndPoint {
  static const String loginApi = "login_webservice.php";
}
