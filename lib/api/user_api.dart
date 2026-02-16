import 'package:chopper/chopper.dart';

import '../domain/user.dart';


part 'user_api.chopper.dart';

@ChopperApi(baseUrl: "/secUser/")
abstract class UserAPI extends ChopperService {
  @Get(path: "/userDetailById")
  Future<Response<User>> auth(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);


  static UserAPI create([ChopperClient? client]) => _$UserAPI(client);
}
