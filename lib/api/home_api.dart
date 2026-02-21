import 'package:chopper/chopper.dart';

import '../domain/response_dto.dart';

part 'home_api.chopper.dart';

@ChopperApi(baseUrl: "/home/")
abstract class HomeAPI extends ChopperService {
  static HomeAPI create([ChopperClient? client]) => _$HomeAPI(client);

  @POST(path: "/initializeData")
  Future<Response<ResponseDTO>> initializeData(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/countNotification")
  Future<Response<ResponseDTO>> countNotification(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/sentBulkMobileNotificationVideo")
  Future<Response<ResponseDTO>> sentBulkMobileNotificationVideo(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

  @POST(path: "/sentBulkMobileNotification")
  Future<Response<ResponseDTO>> sentBulkMobileNotification(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);

}
