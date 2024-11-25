import 'package:either_dart/either.dart';
import 'package:test_app_weather/features/weather/_common/data/mappers/weather_mapper.dart';
import 'package:test_app_weather/features/weather/_common/domain/entity/weather_entity.dart';

import '../../../../../core/app_logger/talker_logger.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/repositories/weather_repositories.dart';
import '../data_sources/weather_local_data_source.dart';
import '../data_sources/weather_remote_data_source.dart';

/// Реализация интерфейса для работы с репозиторием погоды
class WeatherRepositoryImpl with Logger implements WeatherRepository {
  const WeatherRepositoryImpl(
      this.remoteDatasource,
      this.localDataSource,
      this.networkInfo,
      );

  /// Класс - удаленный источник данных
  final WeatherRemoteDataSource remoteDatasource;

  /// Класс - локальный источник данных
  final WeatherLocalDataSource localDataSource;

  /// Класс - проверка подключения к сети
  final NetworkInfo networkInfo;

  /// Метод получения списка погоды
  @override
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName) async {
    try {
      /// Проверка подключения к сети
      final isConnected = await networkInfo.hasConnection;
      if (isConnected) {
        /// Получение данных с сервера
        final data = await remoteDatasource.getWeather(cityName);

        /// Преобразование в сущность
        final result = data.toEntity();

        /// Сохранение данных в локальное хранилище
        localDataSource.saveWeather(data);

        /// Возврат результата
        return Right(result);
      } else {
        /// Получение данных из локального хранилища
        final data = localDataSource.getWeather();

        /// Преобразование в сущность
        final result = data.toEntity();

        /// Возврат результата
        return Right(result);
      }
    } catch (e, st) {
      /// Логирование ошибки
      logger.handle(e, st, 'WeathersRepositoryImpl ::: getWeather');

      /// Возврат результата [Failure]
      return Left(WeatherRepositoryFailure());
    }
  }
}
