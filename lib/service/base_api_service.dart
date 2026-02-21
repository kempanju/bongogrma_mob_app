import 'dart:io';

abstract class BaseApiService {
  Future<dynamic> getApiResponse(String url, dynamic data);
  Future<dynamic> getApiResponseWithToken(String url, dynamic data);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostApiResponseWithToken(String url, dynamic data);
  Future<dynamic> getPostApiResponseWithTokenAndFile(String url, File file);
}