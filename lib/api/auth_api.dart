import 'package:chopper/chopper.dart';

import '../domain/auth_dto.dart';
part 'auth_api.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class AuthAPI extends ChopperService {

  static AuthAPI create([ChopperClient? client]) => _$AuthAPI(client);

  @Post(path: "/login")
  Future<Response<AuthDTO>> accessToken(
      @Body() Map<String, dynamic> mobile
      );
}