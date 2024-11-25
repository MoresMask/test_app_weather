import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Интерфейс для проверки подключения к сети
abstract class NetworkInfo {
  Future<bool> get hasConnection;
}

/// Реализация интерфейса для проверки подключения к сети
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);
  final InternetConnectionChecker connectionChecker;

  /// Проверка подключения к сети (переопределенный геттер)
  @override
  Future<bool> get hasConnection => connectionChecker.hasConnection;
}
