import 'package:logger/logger.dart';

import '../resources/utils/SimpleLogPrinter.dart';


class BaseService {
  Logger? log;
  BaseService({String? title}) {
    log = getLogger(title ?? runtimeType.toString());
  }
}    