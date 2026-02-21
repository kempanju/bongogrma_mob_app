
import 'package:get_it/get_it.dart';
import 'package:habarisasa_flutter/service/storage_service.dart';
import 'package:injectable/injectable.dart';

import '../api/chopper.dart';
import '../api/user_api.dart';
import '../api/user_blocked_api.dart';
import '../api/user_gallery_api.dart';
import '../api/user_status_api.dart';
import '../base/NetworkApiService.dart';
import '../domain/response_dto.dart';
import 'authentication_service.dart';
import 'connection_service.dart';
import 'label_service.dart';

@lazySingleton
class UserService {
  NetworkApiService networkApiService = NetworkApiService();
  UserAPI userAPI = APIClient.getService<UserAPI>();
  UserBlockedAPI userBlockedAPI = APIClient.getService<UserBlockedAPI>();
  UserGalleryAPI userGalleryAPI = APIClient.getService<UserGalleryAPI>();
  UserStatusAPI userStatusAPI = APIClient.getService<UserStatusAPI>();

  final ConnectionService _connectionService = GetIt.I<ConnectionService>();
  final StorageService _storageService = GetIt.I<StorageService>();
  static const String KEY_LOCALE = "locale";
  LabelService locale = GetIt.I<LabelService>();


  Future<ResponseDTO> blockUser(String amount, String phoneNum) async{
    var data = {
      "amount": amount,
      "phoneNo": phoneNum,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userAPI.blockUser(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> searchUser(String textSearch, String currentId) async {
    var data = {
      "text_search": textSearch,
      "userId": currentId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userAPI.searchUser(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> changeFollowStatus(String status, String userId, String followingId) async {
    var data = {
      "status": status,
      "user_id": userId,
      "following_id": followingId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userAPI.changeFollowStatus(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> verifyUser(String userId, String userVerify) async {
    var data = {
      "user_id": userId,
      "user_verify": userVerify,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userAPI.verifyUser(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> myProfile(String email, String userId, String fullName) async {
    var data = {
      "email": email,
      "user_id": userId,
      "full_name": fullName,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userAPI.myProfile(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> updateMyProfile(String userId, String fullNameVal, String summaryTexts, String gender) async {
    var data = {
      "user_id": userId,
      "full_name_val": fullNameVal,
      "summarytexts": summaryTexts,
      "gender": gender,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userAPI.updateMyProfile(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> blockedUser(String userId, String personId, String message) async {
    var data = {
      "user_id": userId,
      "person_id": personId,
      "message": message,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userBlockedAPI.blockedUser(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> galleryAction(String actions, String userId, String imageName) async {
    var data = {
      "actions": actions,
      "user_id": userId,
      "imagename": imageName,
    };

    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userGalleryAPI.galleryAction(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> deleteStatus(String statusId) async {
    var data = {
      "status_id": statusId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userStatusAPI.deleteStatus(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> listStatus(String userId) async {
    var data = {
      "user_id": userId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var userResponse = await userStatusAPI.listStatus(
          AuthenticationService.authToken!, data);
      if (!userResponse.isSuccessful) throw userResponse.error!;
      return userResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

}