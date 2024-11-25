import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/constants/api_keys.dart';
import '../../../_common/data/models/weather_model.dart';

/// Интерфейс для работы с локальным хранилищем
abstract interface class WeatherLocalDataSource {
  /// Метод получения погоды
  WeatherModel getWeather();

  /// Метод сохранения погоды
  void saveWeather(WeatherModel weather);
}

/// Реализация интерфейса для работы с локальным хранилищем
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  const WeatherLocalDataSourceImpl(this.prefs);

  /// [prefs] - хранилище
  final SharedPreferences prefs;

  /// Метод получения погоды
  @override
  WeatherModel getWeather() {
    final result = prefs.getString(ApiKeys.kGetLocalWeather);
    if ((result ?? '').isNotEmpty) {
      return WeatherModel.fromJson((result as Map<String,dynamic>));
    } else {
      return WeatherModel(location: Location(), current: Current());
    }
  }

  /// Метод сохранения погоды
  @override
  void saveWeather(WeatherModel weather) => prefs.setString(
      ApiKeys.kGetLocalWeather, weather.toJson().toString());
}
