import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants({
    required this.endpoint,
    required this.apiKeyContact,
    required this.apiKeyQuote,
    this.appversion,
  });

  factory Constants.of() {
    if (_instance != null) return _instance!;
    _instance = Constants._prd();
    return _instance!;
  }

  factory Constants._prd() {
    return const Constants(
      endpoint: 'http://122.170.107.160/nssg/', //Base URl
      apiKeyContact: 'VmxSQ1YxUldTbFpVYkZaS1UwVTFiMWxyYUZkTlJteFpWVzVDYVUxcVZYZGFWbWhEWWtWNFNGZHVRbXBpYXpSM1dXMHhSMlJHY0ZSbFIzQnBUV3BWZDFkV1pFOU5SbWQ1VGxoYVRWTkZTblpaYWtreFlrVjRTR1ZIYUdwTk1Vb3hWMVpqZUdKRmVFaE5XRnBhWWxkNGVsZHNUalJpUjBwWVVtNUNhVkV6YUhGWmFra3hUVVpzV0ZScVFsbE5helV5V1d4b1EyRkhTblZoTTA1cFZqQmFkMWxyWkhOa1ZtOTZWR3BDYW1KV1duTmFSVTQwWkVac1dHSklUbWhXZWxaMVYxUktjMDFIVmxSbFNGSmFWako0ZWxsV1l6RmliR3Q1VDFSR2FXSnNTalZhVms0MFpFWnNXR0pJVG1oV2VsWjFXbGN4YzJRd2VFaFBWRUpvVWpGYU5WbDZUbE5sVm5CWVZtcENUVko2YTNkWlZXUlhaVlpyZVdKRVFteFZNMmd5V2tWa2IySkhUblJVYmxwclZucFZkMWt5TlhKak1rbDZWVzA1WVZkRmJ6SlpWbWhDV2pGS2MxTnNRbFZWTUVwRldXcEpNVTFHYkZoVWFrSnFaVzVOT1E9PQ==', //for use in future
        apiKeyQuote: 'VmxSQ1YxUldTbFpVYkZaS1UwVlplRmxxVGxOaVJtZDVUbGhhVFZORk5IaFhWekYzWWtacmVsVllUbXBYUmxveVdrVmtWMlZzWjNsV2JsSmFWako0ZWxSRmFFZE5WMGw2VlcxNFdVMXFSakpYVnpGell6RndWMDlZVm10V2VrWndWMnhvU21NeVRsbFdibHByVWpGYU5scEZaRWRpYkhCVVpVZHdhVTFxVlhkWFZtUlBUVVpuZVdKSGRFMVRSVFF4V1hwT1UySkhTbGRQVkVKc1YwVktjMVJGYUVkTlYwbDZWVzE0YWsxVWJIRlpha2w0WkRGc1dFNVVWazFUUlRWMldWWm9RMXB0VFhwVmJteGhWakZaZDFSRmFFOWlNa1paVVcxYVdrMXRkM2RhVms0MFpXMUdTR0pJWkZsTmF6VXlXa1pqTVUxSFRuVmhNMDVxVFcxb2Qxa3dXVFZoYlVsNVZXMTRTbEpXY0ZSV1JFRjNXakZXV1ZadVdtdFNNVm8yVTFWYWExTldTbGRUYTFwS1UwVlplRmxxVGxOaVIwMTZWVzFvWVUxc1ZUVlRha1pEWlZkSmVWUnRlR3BOTURWelYydE9hazUzUFQwPQ==', //for use in future
      appversion: "2.0" //Application version
    );
  }

  static Constants? _instance;

  final String endpoint;
  final String apiKeyContact;
  final String apiKeyQuote;
  final String? appversion;
}

class ResponseStatus {
  static const String failed = "false";
  static const String success = "true";
}

class ApiEndPoint {
  static const String loginApi = "login_webservice.php";
  static const String getContactListApi = "webservice.php";
  static const String getQuoteListApi = "webservice.php";
}