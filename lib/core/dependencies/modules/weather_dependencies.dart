import 'package:test_app_weather/features/weather/weather/presentation/bloc/get_weather_cubit/get_weather_cubit.dart';

import '../../../features/weather/weather/data/data_sources/weather_local_data_source.dart';
import '../../../features/weather/weather/data/data_sources/weather_remote_data_source.dart';
import '../../../features/weather/weather/data/repositories/weather_repository_impl.dart';
import '../../../features/weather/weather/domain/repositories/weather_repositories.dart';
import '../../../features/weather/weather/domain/use_case/get_weather_use_case.dart';
import '../injection_container.dart';

/// Регистрация зависимостей для модуля weather
void weatherDependencies() {
  getIt
    ..registerFactory<GetWeatherCubit>(() => GetWeatherCubit(getIt()))

  /// Usecases
    ..registerLazySingleton<GetWeatherUseCase>(() => GetWeatherUseCase(getIt()))

  /// Repositories
    ..registerLazySingleton<WeatherRepository>(
            () => WeatherRepositoryImpl(getIt(), getIt(), getIt()))

  /// Data sources
    ..registerLazySingleton<WeatherLocalDataSource>(
            () => WeatherLocalDataSourceImpl(getIt()))
    ..registerLazySingleton<WeatherRemoteDataSource>(
            () => WeatherRemoteDataSourceImpl(getIt()));
}
