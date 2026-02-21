import 'package:chopper/chopper.dart';

import '../domain/response_dto.dart';
import '../domain/user.dart';


part 'user_api.chopper.dart';

@ChopperApi(baseUrl: "/secUser/")
abstract class UserAPI extends ChopperService {
  @GET(path: "/userDetailById")
  Future<Response<User>> auth(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);


  static UserAPI create([ChopperClient? client]) => _$UserAPI(client);

  @POST(path: "/blockUser")
  Future<Response<ResponseDTO>> blockUser(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/searchUser")
  Future<Response<ResponseDTO>> searchUser(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/changeFollowStatus")
  Future<Response<ResponseDTO>> changeFollowStatus(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/verifyUser")
  Future<Response<ResponseDTO>> verifyUser(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/myProfile")
  Future<Response<ResponseDTO>> myProfile(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/updateMyProfile")
  Future<Response<ResponseDTO>> updateMyProfile(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

}
