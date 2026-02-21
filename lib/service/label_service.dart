import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:habarisasa_flutter/service/storage_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LabelService {
  static const String KEY_LOCALE = "locale";
  static const String DEFAULT_LOCALE = "sw";

  final StorageService _storageService = GetIt.I<StorageService>();

  String get groupMenuLabel => 'group-menu-label'.tr();
  String get appTitleLabel => 'Mshiko Kiganjani'.tr();

}
