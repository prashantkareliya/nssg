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
      apiKey: 'VmxSQ1YxUldTbFpVYkZaS1UwVTFiMWxyYUZkTlJteFpWVzVDYVUxcVZYZGFWbWhEWWtWNFNGZHVRbXBpYXpSM1dXMHhSMlJHY0ZSbFIzQnBUV3BWZDFkV1pFOU5SbWQ1VGxoYVRWTkZTblpaYWtreFlrVjRTR1ZIYUdwTk1Vb3hWMVpqZUdKRmVFaE5XRnBhWWxkNGVsZHNUalJpUjBwWVVtNUNhVkV6YUhGWmFra3hUVVpzV0ZScVFsbE5helV5V1d4b1EyRkhTblZoTTA1cFZqQmFkMWxyWkhOa1ZtOTZWR3BDYW1KV1duTmFSVTQwWkVac1dHSklUbWhXZWxaMVYxUktjMDFIVmxSbFNGSmFWako0ZWxsV1l6RmliR3Q1VDFSR2FXSnNTalZhVms0MFpFWnNXR0pJVG1oV2VsWjFXbGN4YzJRd2VFaFBWRUpvVWpGYU5WbDZUbE5sVm5CWVZtcENUVko2YTNkWlZXUlhaVlpyZVdKRVFteFZNMmd5V2tWa2IySkhUblJVYmxwclZucFZkMWt5TlhKak1rbDZWVzA1WVZkRmJ6SlpWbWhDV2pGS2MxTnNRbFZWTUVwRldXcEpNVTFHYkZoVWFrSnFaVzVOT1E9PQ==', //for use in future
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
  static const String getContactListApi = "webservice.php";

}
