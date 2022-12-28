import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nssg/constants/strings.dart';

import '../constants/constants.dart';

class HttpActions {
  String endPoint = Constants.of().endpoint;
  late BuildContext context;

  HttpActions(this.context);

  Future<dynamic> postMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      http.Response response = await http.post(Uri.parse(endPoint + url),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> getMethod(String url, {Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      http.Response response =
          await http.get(Uri.parse(endPoint + url), headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> patchMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      http.Response response = await http.patch(Uri.parse(endPoint + url),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> putMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      http.Response response = await http.put(Uri.parse(endPoint + url),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> deleteMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      http.Response response = await http.delete(Uri.parse(endPoint + url),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<Map<String, String>> getSessionData(
      Map<String, String> headers) async {
    headers["content-type"] = "application/json";
    return headers;
  }

  Future<ConnectivityResult> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }

  Future<dynamic> postMethodQueryParams(String url,
      {dynamic queryParameters, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      url = endPoint + queryParameters.toString();
      headers = await getSessionData(headers ?? {});
      http.Response response =
          await http.post(Uri.parse(url), headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }
}
