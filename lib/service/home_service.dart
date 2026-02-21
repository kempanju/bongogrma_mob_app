
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../api/chopper.dart';
import '../api/home_api.dart';
import '../base/NetworkApiService.dart';
import '../domain/response_dto.dart';
import 'authentication_service.dart';
import 'connection_service.dart';

@lazySingleton
class HomeService {
  NetworkApiService networkApiService = NetworkApiService();
  HomeAPI homeAPI = APIClient.getService<HomeAPI>();
  final ConnectionService _connectionService = GetIt.I<ConnectionService>();

  Future<ResponseDTO> initializeData(String userId, String tempName, String countryCode, String appVersion, String phoneToken) async {
    var data = {
      "user_id": userId,
      "temp_name": tempName,
      "countryCode": countryCode,
      "app_version": appVersion,
      "phone_token": phoneToken,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var homeResponse = await homeAPI.initializeData(
          AuthenticationService.authToken!, data);
      if (!homeResponse.isSuccessful) throw homeResponse.error!;
      return homeResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> countNotification(String userId, String lastAccess) async {
    var data = {
      "user_id": userId,
      "lastaccess": lastAccess,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var homeResponse = await homeAPI.countNotification(
          AuthenticationService.authToken!, data);
      if (!homeResponse.isSuccessful) throw homeResponse.error!;
      return homeResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> sentBulkMobileNotificationVideo(String contentType, String desc, String userId, String filePaths, String imageId) async {
    var data = {
      "contentype": contentType,
      "desc": desc,
      "userid": userId,
      "filepaths": filePaths,
      "imageid": imageId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var homeResponse = await homeAPI.sentBulkMobileNotificationVideo(
          AuthenticationService.authToken!, data);
      if (!homeResponse.isSuccessful) throw homeResponse.error!;
      return homeResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> sentBulkMobileNotification(String type, String uniqueValue, String titles, String msg) async {
    var data = {
      "type": type,
      "uniquevalue": uniqueValue,
      "titless": titles,
      "msg": msg,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var homeResponse = await homeAPI.sentBulkMobileNotification(
          AuthenticationService.authToken!, data);
      if (!homeResponse.isSuccessful) throw homeResponse.error!;
      return homeResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

}