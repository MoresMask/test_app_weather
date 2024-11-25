
import 'package:test_app_weather/features/weather/_common/data/models/weather_model.dart';
import '../../domain/entity/weather_entity.dart';

/// Расширение для преобразования модели погоды в сущность погоды ([WeatherModel] to [WeatherEntity])
extension WeatherModelToEntity on WeatherModel {
  WeatherEntity toEntity() {
    return WeatherEntity(
      location: location,
      current: current
    );
  }
}