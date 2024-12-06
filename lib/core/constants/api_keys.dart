/// [ApiKeys] - класс для хранения ключей API
abstract class ApiKeys {
  /// [baseUrl] - базовый URL
  static const baseUrl = 'http://api.weatherapi.com/v1/';

  /// [apiKeys] - Токен апи
  static const apiKeys = "06da0ebda51d467d94272123240612";

  /// [GET] - запрос на получение погоды
  static const kGetWeather = '/current.json';


  /// Ключ для хранения погоды в локальном хранилище
  static const kGetLocalWeather = 'weather';

  static const kGetNameCity = 'Омск';

}