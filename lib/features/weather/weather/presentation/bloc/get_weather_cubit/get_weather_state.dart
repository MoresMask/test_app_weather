import 'package:test_app_weather/features/weather/_common/domain/entity/weather_entity.dart';

/// Состояния для cubit
/// [GetWeatherState] - базовый класс для всех состояний
sealed class GetWeatherState {}

/// Состояние при инициализации cubit
class GetWeatherStateInitial extends GetWeatherState {}

/// Состояние при загрузке данных
class GetWeatherStateLoading extends GetWeatherState {}

/// Состояние при успешной загрузке данных
class GetWeatherStateSuccess extends GetWeatherState {
  GetWeatherStateSuccess({this.weather});

  /// Погода
  final WeatherEntity? weather;

  GetWeatherStateSuccess copyWith({WeatherEntity? weather}){
    return GetWeatherStateSuccess(
        weather: weather ?? this.weather
    );

  }
}

/// Состояние при ошибке
class GetWeatherStateError extends GetWeatherState {}
