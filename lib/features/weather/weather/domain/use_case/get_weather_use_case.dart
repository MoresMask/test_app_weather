import 'package:either_dart/either.dart';
import 'package:test_app_weather/features/weather/_common/domain/entity/weather_entity.dart';

import '../../../../../core/base/usecase.dart';
import '../../../../../core/failure/failure.dart';
import '../repositories/weather_repositories.dart';

/// UseCase для получения погоды
class GetWeatherUseCase extends UseCase<WeatherEntity, Param> {
  const GetWeatherUseCase(this._repository);
  final WeatherRepository _repository;

  @override
  Future<Either<Failure, WeatherEntity>> call(Param params) async =>
      _repository.getWeather(params.cityName);
}
