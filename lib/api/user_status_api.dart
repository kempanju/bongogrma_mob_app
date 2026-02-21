import 'package:chopper/chopper.dart';

import '../domain/response_dto.dart';

part 'user_status_api.chopper.dart';

@ChopperApi(baseUrl: "/usersStatus/")
abstract class UserStatusAPI extends ChopperService {
  static UserStatusAPI create([ChopperClient? client]) => _$UserStatusAPI(client);

  @POST(path: "/listStatus")
  Future<Response<ResponseDTO>> listStatus(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/deleteStatus")
  Future<Response<ResponseDTO>> deleteStatus(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);
}