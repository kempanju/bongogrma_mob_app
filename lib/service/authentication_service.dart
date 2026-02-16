import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:habarisasa_flutter/service/storage_service.dart';
import 'package:injectable/injectable.dart';

import '../api/auth_api.dart';
import '../api/chopper.dart';
import '../api/user_api.dart';
import '../domain/auth_dto.dart';
import '../domain/user.dart';
import 'connection_service.dart';

@lazySingleton
class AuthenticationService {
  static const AUTH_TOKEN_HEADER_KEY = "authorization";

  UserAPI userAPI = APIClient.getService<UserAPI>();
  AuthAPI authAPI = APIClient.getService<AuthAPI>();
  final ConnectionService _connectionService = GetIt.I<ConnectionService>();
  final StorageService _storageService = GetIt.I<StorageService>();

  static String? _authToken;

  static User? _currentUser;


  static bool get isAuthenticated {
    return authToken != null;
  }

  static String? get authToken {
    return _authToken;
  }

  static User? get currentUser {
    return _currentUser;
  }

  String toBasicAuthToken(String userId, String password) {
    var encodedAuth = utf8.encode("${userId.trim()}:${password.trim()}");
    var basicAuth = "Basic ${base64Encode(encodedAuth)}";

    return basicAuth;
  }


  Future<User?> _authenticateRemotely(String userId, String password) async {
    var basicAuth = toBasicAuthToken(userId, password);

    var data = {
      "username": "ddd",
    };

    var response = await userAPI.auth(basicAuth,data);
    if (!response.isSuccessful) throw response.error!;

    var user = response.body;

    AuthenticationService._authToken = basicAuth;
    AuthenticationService._currentUser = user;

    var userStorage = _storageService.access<User>(User.OFFLINE_STORAGE_NAME);
    await userStorage.put(userId, user!);

    var settingStorage =
        _storageService.access(StorageService.SETTING_OFFLINE_STORAGE_NAME);
    await settingStorage.put("$userId:password", password);



   /* var groupResponse = await _groupService.findAllGroups(user.id.toString());
    if (!groupResponse.isSuccessful)
      throw "${groupResponse.error!}  please contact administrator";
    var groups = groupResponse.body;
*/

    //await _synchronizeOfflineData(user.loginId);

    return user;
  }
  Future<User?> _authenticate(String userId, String password) async {

    var data = {
      "username": userId,
      "password":password
    };
    var response = await authAPI.accessToken(data);
    if (!response.isSuccessful) throw response.error!;

    AuthDTO authDTO = response.body!;

    String authToken = "${authDTO.token_type!} ${authDTO.access_token!}";
    AuthenticationService._authToken = authToken;

    var userResponse = await userAPI.auth(authToken,data);
    if(userResponse.statusCode == 401) {
      throw "Invalid username or password";
    }
    if (!userResponse.isSuccessful) throw response.error!;


    User user = userResponse.body!;
    AuthenticationService._currentUser = user;

    var userStorage = _storageService.access<User>(User.OFFLINE_STORAGE_NAME);
    await userStorage.put(userId, user);

    var settingStorage =
    _storageService.access(StorageService.SETTING_OFFLINE_STORAGE_NAME);
    await settingStorage.put("$userId:token", authToken);
    await settingStorage.put("userId", userId);

    return user;
  }

  Future<User?> login(String userId, String password) async {
    var connected = await _connectionService.isNetworkConnected();
    if (connected) {
      return await _authenticate(userId, password);
    } else {
      throw "Please connect to internet";
    }
  }

  String? get currentUserId {
    return _storageService
        .access(StorageService.SETTING_OFFLINE_STORAGE_NAME)
        .get("userId");
  }

  Future<void> logout() async {
    AuthenticationService._authToken = null;
    AuthenticationService._currentUser = null;

    _storageService
        .access(StorageService.SETTING_OFFLINE_STORAGE_NAME).delete("userId");

  }

}
