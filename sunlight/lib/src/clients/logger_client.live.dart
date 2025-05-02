import 'dart:developer';

import 'package:sunlight/src/clients/logger_client.dart';

final consoleLoggerClient = LoggerClient(log: log);
final noneLoggerClient = LoggerClient(log: (_) {});
