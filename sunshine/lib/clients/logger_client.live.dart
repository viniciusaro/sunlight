import 'dart:developer';

import 'package:sunshine_events/clients/logger_client.dart';

final consoleLoggerClient = LoggerClient(log: log);
final noneLoggerClient = LoggerClient(log: (_) {});
