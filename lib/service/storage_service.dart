import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../domain/user.dart';

@lazySingleton
class StorageService {
  static const SETTING_OFFLINE_STORAGE_NAME = "Settings";

  Future<void> init() async {
    String path = "";
    if (kIsWeb) {
      path = "/Users/felixjoseph/AndroidStudioProjects/habarisasa";
    } else {
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      path = appDocumentDirectory.path;
    }
    Hive.init(path);
    //Hive.registerAdapter(UserAdapter());
  }

  Future<void> openStorage() async {
    await open<User>(User.OFFLINE_STORAGE_NAME);
    await open(SETTING_OFFLINE_STORAGE_NAME);
  }

  Future<Box<T>> open<T>(String name) async {
    var box = await Hive.openBox<T>(name);
    return box;
  }

  Box<T> access<T>(String name) {
    return Hive.box<T>(name);
  }

  Future delete(String name, dynamic key) async {
    await Hive.box(name).delete(key);
  }

  Future<void> deleteWhere<T>(
      String name, bool Function(dynamic, T) predicate) async {
    var storage = access<T>(name);

    var candidateKey;
    storage.toMap().forEach((key, value) {
      if (predicate(key, value)) {
        candidateKey = key;
      }
    });

    if (candidateKey != null) await storage.delete(candidateKey);
  }
}
