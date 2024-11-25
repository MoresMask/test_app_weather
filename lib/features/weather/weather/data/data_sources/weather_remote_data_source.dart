import 'package:test_app_weather/features/weather/_common/data/models/weather_model.dart';
import 'package:dio/dio.dart';

import '../../../../../core/constants/api_keys.dart';
/// Интерфейс для получения данных с сервера
abstract interface class WeatherRemoteDataSource {
  /// Метод получения погоды
  Future<WeatherModel> getWeather(String cityName);
}

///  Реализация интерфейса для получения данных с сервера
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
   const WeatherRemoteDataSourceImpl(this._dio,);


  /// Клиент для отправки запросов
  final Dio _dio;



  /// Метод получения погоды
  @override
  Future<WeatherModel> getWeather(String cityName) async {
    return await _dio.get(ApiKeys.kGetWeather, queryParameters: {"key" : "18a98a2ba8154b80b9a110843242411", "q": cityName, "lang": "ru" }).then(
          (response) => WeatherModel.fromJson(response.data)
    );
  }
}