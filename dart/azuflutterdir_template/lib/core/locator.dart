import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import 'package:{{PACKAGE_NAME}}/data/service/logger/logger.dart';

export 'package:get_it/get_it.dart' show GetIt;
export 'package:{{PACKAGE_NAME}}/data/service/logger/logger.dart';

final GetIt locator = GetIt.instance;

LoggingLibrary get logger => locator.get<LoggingLibrary>();
WidgetsBinding get widgetsBinding => locator.get<WidgetsBinding>();
