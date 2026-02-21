import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../api/chopper.dart';
import '../api/comment_api.dart';
import '../base/NetworkApiService.dart';
import '../domain/response_dto.dart';
import 'authentication_service.dart';
import 'connection_service.dart';

@lazySingleton
class CommentService {
  NetworkApiService networkApiService = NetworkApiService();
  CommentAPI commentAPI = APIClient.getService<CommentAPI>();
  final ConnectionService _connectionService = GetIt.I<ConnectionService>();

  Future<ResponseDTO> commentList(String postId, String userId, String limit) async {
    var data = {
      "post_id": postId,
      "user_id": userId,
      "limit": limit,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var commentResponse = await commentAPI.commentList(
          AuthenticationService.authToken!, data);
      if (!commentResponse.isSuccessful) throw commentResponse.error!;
      return commentResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> commentLike(String commentId, String userId) async {
    var data = {
      "comment_id": commentId,
      "user_id": userId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var commentResponse = await commentAPI.commentLike(
          AuthenticationService.authToken!, data);
      if (!commentResponse.isSuccessful) throw commentResponse.error!;
      return commentResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> deleteCommentLike(String commentId, String userId) async {
    var data = {
      "comment_id": commentId,
      "user_id": userId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var commentResponse = await commentAPI.deleteCommentLike(
          AuthenticationService.authToken!, data);
      if (!commentResponse.isSuccessful) throw commentResponse.error!;
      return commentResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> deleteComment(String commentId) async {
    var data = {
      "comment_id": commentId,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var commentResponse = await commentAPI.deleteComment(
          AuthenticationService.authToken!, data);
      if (!commentResponse.isSuccessful) throw commentResponse.error!;
      return commentResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

  Future<ResponseDTO> saveCommentApp(String imageId, String userId, String comment) async {
    var data = {
      "image_id": imageId,
      "userid": userId,
      "comment": comment,
    };
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      var commentResponse = await commentAPI.saveCommentApp(
          AuthenticationService.authToken!, data);
      if (!commentResponse.isSuccessful) throw commentResponse.error!;
      return commentResponse.body!;
    } else {
      throw "Please connect to internet";
    }
  }

}