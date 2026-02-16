
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConnectionService {

  Future<bool> isNetworkConnected() async {
    var connectivityResult = await checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<List<ConnectivityResult>> checkConnectivity()  {
    var connectivityResult =  (Connectivity().checkConnectivity());
    return connectivityResult;
  }

}
