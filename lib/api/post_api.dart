
import 'package:chopper/chopper.dart';

import '../domain/response_dto.dart';
part 'post_api.chopper.dart';

@ChopperApi(baseUrl: "/posts/")
abstract class PostAPI extends ChopperService {
  static PostAPI create([ChopperClient? client]) => _$PostAPI(client);

  @POST(path: "/deletePost")
  Future<Response<ResponseDTO>> deletePost(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/editPost")
  Future<Response<ResponseDTO>> editPost(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/getPostById")
  Future<Response<ResponseDTO>> getPostById(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/notificationList")
  Future<Response<ResponseDTO>> notificationList(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/listNotification")
  Future<Response<ResponseDTO>> listNotification(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/getPosts")
  Future<Response<ResponseDTO>> getPosts(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/postListLoc")
  Future<Response<ResponseDTO>> postListLoc(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/randomVideos")
  Future<Response<ResponseDTO>> randomVideos(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/postList")
  Future<Response<ResponseDTO>> postList(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/postByUser")
  Future<Response<ResponseDTO>> postByUser(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/searchPost")
  Future<Response<ResponseDTO>> searchPost(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

}