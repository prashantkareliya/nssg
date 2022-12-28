import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nssg/constants/strings.dart';

import '../constants/constants.dart';

class HttpActions {
  String endPoint = Constants.of().endpoint;

  Future<dynamic> postMethod(String url,
      {dynamic data, Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
       String finalUrl =endPoint + url;
      if(queryParams != null){
        queryParams.forEach((key, value) {
          if(key == queryParams.keys.first){
            finalUrl = "$finalUrl?$key=$value";
          }else{
            finalUrl = "$finalUrl&$key=$value";
          }
        });
      }
      http.Response response = await http.post(Uri.parse(finalUrl),
          body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> getMethod(String url, {Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});

      String finalUrl =endPoint + url;
      if(queryParams != null){
        queryParams.forEach((key, value) {
          if(key == queryParams.keys.first){
            finalUrl = "$finalUrl?$key=$value";
          }else{
            finalUrl = "$finalUrl&$key=$value";
          }
        });
      }
      print("URl -- $finalUrl");
      http.Response response =
          await http.get(Uri.parse(finalUrl), headers: headers);
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

  Future<dynamic> postMethodQueryParams(
      {String? url,
      dynamic queryParameters,
      Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {

      Map<String, String> queryParameters = {
        'username': "dn@nssg.co.uk",
        'password': "passwordController.text.trim()",
        'accesskey': 'S8QzomH4Q4QYxaFb',
      };


      url = endPoint + queryParameters.toString();
      headers = await getSessionData(headers ?? {});
      http.Response response = await http.post(Uri.parse(url), headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }
}
