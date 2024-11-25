
import 'package:either_dart/either.dart';
import 'package:test_app_weather/features/weather/_common/domain/entity/weather_entity.dart';

import '../../../../../core/failure/failure.dart';

/// Интерфейс для работы с репозиторием погоды
abstract interface class WeatherRepository {
  /// Метод получения списка погоды
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName);
}
