
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../api/chopper.dart';
import '../api/post_api.dart';
import '../base/NetworkApiService.dart';
import '../domain/response_dto.dart';
import 'authentication_service.dart';
import 'connection_service.dart';

@lazySingleton
class PostService {
  NetworkApiService networkApiService = NetworkApiService();
  PostAPI postAPI = APIClient.getService<PostAPI>();
  final ConnectionService _connectionService = GetIt.I<ConnectionService>();

  Future<ResponseDTO> deletePost(String postId) async {
    var data = {
      "post_id": postId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.deletePost(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> editPost(String postId, String description) async {
    var data = {
      "post_id": postId,
      "description": description,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.editPost(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> getPostById(String postId, String userId) async {
    var data = {
      "post_id": postId,
      "user_id": userId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.getPostById(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> notificationList(String userId) async {
    var data = {
      "user_id": userId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.notificationList(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> listNotification(String userId) async {
    var data = {
      "userid": userId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.listNotification(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> getPosts(String userId, String src, String max, String tagSelected, String centroidX, String centroidY, String cityName, String appVersion, String phoneToken) async {
    var data = {
      "user_id": userId,
      "src": src,
      "max": max,
      "tagselected": tagSelected,
      "centroid_x": centroidX,
      "centroid_y": centroidY,
      "city_name": cityName,
      "app_version": appVersion,
      "phone_token": phoneToken,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.getPosts(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> postListLoc(String userId, String src, String max, String countryCode, String appVersion, String phoneToken, String centroidX, String centroidY, String cityName) async {
    var data = {
      "user_id": userId,
      "src": src,
      "max": max,
      "countryCode": countryCode,
      "app_version": appVersion,
      "phone_token": phoneToken,
      "centroid_x": centroidX,
      "centroid_y": centroidY,
      "city_name": cityName,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.postListLoc(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> randomVideos(String userId, String ownerId, String postId) async {
    var data = {
      "user_id": userId,
      "owner_id": ownerId,
      "post_id": postId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.randomVideos(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> postList(String userId, String src, String max, String countryCode, String tagSelected, String centroidX, String centroidY, String cityName, String phoneToken) async {
    var data = {
      "user_id": userId,
      "src": src,
      "max": max,
      "countryCode": countryCode,
      "tagselected": tagSelected,
      "centroid_x": centroidX,
      "centroid_y": centroidY,
      "city_name": cityName,
      "phone_token": phoneToken,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.postList(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> postByUser(String userId) async {
    var data = {
      "user_id": userId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.postByUser(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> searchPost(String searchString, String src) async {
    var data = {
      "searchstring": searchString,
      "src": src,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var postResponse = await postAPI.searchPost(
          AuthenticationService.authToken!, data);
      if (!postResponse.isSuccessful) throw postResponse.error!;
      return postResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

}