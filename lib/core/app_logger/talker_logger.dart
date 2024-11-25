import 'package:talker_flutter/talker_flutter.dart';

import '../dependencies/injection_container.dart';

/// Абстракция логгера приложения
abstract interface class ITalkerAppLogger{
  void log({
    required LogLevel level,
    required String message,
    Object? error,
    StackTrace? stackTrace});

  void handle(Object error, [StackTrace? stackTrace, String msg]);
}

/// Реализация логгера приложения на основе [Talker].
class TalkerAppLogger implements ITalkerAppLogger {
  TalkerAppLogger({
    required Talker talker,
  }) : _talker = talker;

  final Talker _talker;


  @override
  void log({
    required LogLevel level,
    required String message,
    Object? error,
    StackTrace? stackTrace}) =>
      switch(level){
        LogLevel.debug => _talker.debug(message, error, stackTrace),
        LogLevel.info => _talker.info(message, error, stackTrace),
        LogLevel.warning => _talker.warning(message, error, stackTrace),
        LogLevel.error => _talker.error(message, error, stackTrace),
        LogLevel.critical => _talker.critical(message, error, stackTrace),
        LogLevel.verbose => _talker.verbose(message, error, stackTrace),
      };

  @override
  void handle(Object error, [StackTrace? stackTrace, String? msg])=>
      _talker.handle(error, stackTrace, msg);
}

/// Миксин для быстрого доступа к логгеру приложения.
mixin Logger {
  ITalkerAppLogger get logger => getIt<ITalkerAppLogger>();
}
