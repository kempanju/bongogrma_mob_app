

import 'package:chopper/chopper.dart';

import 'package:flutter/foundation.dart';
import 'package:habarisasa_flutter/api/user_api.dart';



import '../domain/auth_dto.dart';
import '../domain/user.dart';
import 'auth_api.dart';
import 'error_converter.dart';
import 'model_converter.dart';

final JSONConverters = {
  User: (json) => User.fromJson(json),
  AuthDTO: (json) => AuthDTO.fromJson(json),
  Map: (json) => json,
  dynamic: (json) => json,
  Object: (json) => json,
};

final CollectAPIServices = [
  UserAPI.create(),
  AuthAPI.create()
];


ChopperClient? _APIClient;


/*
void initCollectDocsClient() {
  _DocsClient = ChopperClient(
    // The first part of the URL is here
    baseUrl:Uri.parse(Environment.APP_COLLECT_GATEWAY_BASE_URL),
    services: DocsAPIServices,

    interceptors: [
      HeadersInterceptor({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }),
    ],
    // Converts data to & from JSON and adds the application/json header.
    converter: JsonSerializableConverter(JSONConverters),
    errorConverter: APIErrorConverter(),
  );
}
*/


ChopperClient get APIClient {
  if (_APIClient == null) {
    throw Exception("Collect API client is not initialised yet");
  }
  return _APIClient!;
}

void initCollectAPIClient(String baseAPIURL) {

  if(kDebugMode){
    //baseAPIURL = "http://192.168.37.188:8484/api";
    baseAPIURL = "http://app.habarisasa.com:9797/api";

  } else {
    baseAPIURL = "http://app.habarisasa.com:9797/api";
  }
  _APIClient = ChopperClient(
    // The first part of the URL is here
    baseUrl: Uri.parse(baseAPIURL),
    services: CollectAPIServices,

    interceptors: [
      HeadersInterceptor({
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }),
      // HttpLoggingInterceptor(),
     // CollectUserAuthInterceptor(),
      // CurlInterceptor(),
    ],
    // Converts data to & from JSON and adds the application/json header.
    converter: JsonSerializableConverter(JSONConverters),
    errorConverter: APIErrorConverter(),
  );
}


