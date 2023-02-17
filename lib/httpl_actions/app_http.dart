import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nssg/constants/strings.dart';

import '../constants/constants.dart';
import '../screens/qoute/add_quote/models/create_quote_response.dart';

class HttpActions {
  String endPoint = Constants.of().endpoint;

  Future<dynamic> postMethod(String url, {dynamic data, Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      String finalUrl = endPoint + url;
      if (queryParams != null) {
        queryParams.forEach((key, value) {
          if (key == queryParams.keys.first) {
            finalUrl = "$finalUrl?$key=$value";
          } else {
            finalUrl = "$finalUrl&$key=$value";
          }
        });
      }
      http.Response response = await http.post(Uri.parse(finalUrl), body: data, headers: headers);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> getMethod(String url,
      {Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});

      String finalUrl = endPoint + url;
      if (queryParams != null) {
        queryParams.forEach((key, value) {
          if (key == queryParams.keys.first) {
            finalUrl = "$finalUrl?$key=$value";
          } else {
            finalUrl = "$finalUrl&$key=$value";
          }
        });
      }
      debugPrint("URl -- $finalUrl");
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
   // headers["content-type"] = "application/json";
    headers["content-type"] = "multipart/form-data";
    return headers;
  }

  Future<ConnectivityResult> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }

  Future<dynamic> postMethodQueryParams(
      String url, {dynamic data, Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {

    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = await getSessionData(headers ?? {});
      String finalUrl = endPoint + url;
      var request = http.MultipartRequest('POST', Uri.parse(finalUrl));
      request.fields.addAll(data);
      //http.StreamedResponse response = await request.send();

      var response = await request.send();


      if (response.statusCode == 200) {

        var responsed = await http.Response.fromStream(response);
        final responseData = json.decode(responsed.body);
        return responseData;
      } else {
        print(response.reasonPhrase);
      }


    } else {
      Future.error(ErrorString.noInternet);
    }
  }
}
