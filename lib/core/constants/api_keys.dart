/// [ApiKeys] - класс для хранения ключей API
abstract class ApiKeys {
  /// [baseUrl] - базовый URL
  static const baseUrl = 'http://api.weatherapi.com/v1/';

  /// [apiKeys] - Токен апи
  static const apiKeys = "18a98a2ba8154b80b9a110843242411";

  /// [GET] - запрос на получение погоды
  static const kGetWeather = '/current.json';


  /// Ключ для хранения погоды в локальном хранилище
  static const kGetLocalWeather = 'weather';

  static const kGetNameCity = 'Омск';

}