import 'package:chopper/chopper.dart';

import '../domain/response_dto.dart';

part 'user_gallery_api.chopper.dart';

@ChopperApi(baseUrl: "/userGallery/")
abstract class UserGalleryAPI extends ChopperService {
  static UserGalleryAPI create([ChopperClient? client]) => _$UserGalleryAPI(client);

  @POST(path: "/galleryAction")
  Future<Response<ResponseDTO>> galleryAction(@Header("Authorization") String authToken, @Body() Map<String, dynamic> data);


}