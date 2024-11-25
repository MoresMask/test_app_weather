import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:test_app_weather/core/app_logger/talker_logger.dart';
import 'package:test_app_weather/core/dependencies/modules/weather_dependencies.dart';

import '../constants/api_keys.dart';
import '../network/network_info.dart';


/// [getIt] - глобальный синглтон для DI (контейнер зависимостей)

final getIt = GetIt.instance;
late final SharedPreferences _prefs;

/// Метод инициализации DI
Future<void> getInit() async {
  /// Инициализация логгера
  final talker = TalkerFlutter.init();

  ///  Инициализация наблюдателя блока
  final talkerBlocObserver = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printChanges: true,
      printCreations: true,
      printClosings: true,
    ),
  );

  /// Инициализация логгера для Dio
  final talkerDioLogger = TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(printRequestHeaders: true),
  );

  /// Инициализация Dio
  final dio = Dio(BaseOptions(
    baseUrl: ApiKeys.baseUrl,
    sendTimeout: const Duration(seconds: 60),
    connectTimeout: const Duration(seconds: 60),
    contentType: 'application/json',
  ));

  /// Инициализация SharedPreferences
  _prefs = await SharedPreferences.getInstance();

  /// Добавление интерсепторов
  dio.interceptors.add(talkerDioLogger);

  /// Инициализация основных зависимостей для работы приложения
  getIt
    ..registerLazySingleton<SharedPreferences>(() => _prefs)
    ..registerLazySingleton<Dio>(() => dio)
    ..registerLazySingleton<InternetConnectionChecker>(
        InternetConnectionChecker.createInstance)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()))
    ..registerLazySingleton<Talker>(() => talker)
    ..registerLazySingleton<ITalkerAppLogger>(
            () => TalkerAppLogger(talker: talker))
    ..registerLazySingleton<TalkerBlocObserver>(() => talkerBlocObserver)
    ..registerLazySingleton<TalkerDioLogger>(() => talkerDioLogger);

  //* ------- Инициализация зависимостей для модуля "Weather" ------- *//
  weatherDependencies();
}