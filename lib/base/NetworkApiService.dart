import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../network/ApiException.dart';
import '../service/base_api_service.dart';
import 'package:http/http.dart' as http;

import 'BaseService.dart';

class NetworkApiService extends BaseService implements BaseApiService {
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 403:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        FetchDataException(
            'Error while Communication with status code${response.statusCode}');
    }
  }

  @override
  Future getApiResponse(String url, dynamic data) async {
    String queryString = '';
    String requestUrl = '';
    if (data == null) {
      requestUrl = url;
    } else {
      queryString = Uri(queryParameters: data).query;
      requestUrl = '$url?$queryString';
    }
    final headers = {"Accept": "application/json"};
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(requestUrl), headers: headers).timeout(
                const Duration(
                  seconds: 20,
                ),
              );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getApiResponseWithToken(String url, data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token')!;
    String queryString = '';
    String requestUrl = '';
    if (data == null) {
      requestUrl = url;
    } else {
      queryString = Uri(queryParameters: data).query;
      requestUrl = '$url?$queryString';
    }
    final headers = {
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(requestUrl), headers: headers).timeout(
                const Duration(
                  seconds: 20,
                ),
              );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future<http.Response> getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      final response = await http
          .post(Uri.parse(url), body: json.encode(data), headers: headers)
          .timeout(const Duration(seconds: 30));
      return responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
     // log('error$e');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponseWithToken(String url, data) async {
    dynamic responseJson;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http
          .post(Uri.parse(url), body: json.encode(data), headers: headers)
          .timeout(const Duration(seconds: 30));
      return responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
     // log('error$e');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponseWithTokenAndFile(String url, File file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token')!;
    dynamic responseJson;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(http.MultipartFile.fromBytes(
          "picture", File(file.path).readAsBytesSync(),
          filename: file.path));
      var res = await request.send();
      if (res.statusCode == 200) {
        final resp = await http.Response.fromStream(res);
        return responseJson = returnResponse(resp);
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      //log('error$e');
    }

    return responseJson;
  }
}