import 'package:chopper/chopper.dart';

import '../domain/response_dto.dart';

part 'comment_api.chopper.dart';

@ChopperApi(baseUrl: "/comments/")
abstract class CommentAPI extends ChopperService {
  static CommentAPI create([ChopperClient? client]) => _$CommentAPI(client);

  @POST(path: "/commentList")
  Future<Response<ResponseDTO>> commentList(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/commentLike")
  Future<Response<ResponseDTO>> commentLike(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/deleteCommentLike")
  Future<Response<ResponseDTO>> deleteCommentLike(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/deleteComment")
  Future<Response<ResponseDTO>> deleteComment(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/saveCommentApp")
  Future<Response<ResponseDTO>> saveCommentApp(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

}