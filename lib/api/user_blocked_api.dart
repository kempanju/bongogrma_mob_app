import 'package:chopper/chopper.dart';

import '../domain/response_dto.dart';

part 'user_blocked_api.chopper.dart';

@ChopperApi(baseUrl: "/secUser/")
abstract class UserBlockedAPI extends ChopperService {

  @POST(path: "/saveBlockedUser")
  Future<Response<ResponseDTO>> blockedUser(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  static UserBlockedAPI create([ChopperClient? client]) => _$UserBlockedAPI(client);

}