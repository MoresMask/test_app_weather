import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_weather/core/failure/failure.dart';

/// Базовый класс для реализации UseCase
/// [Type] - тип возвращаемого значения
/// [Params] - параметры для выполнения UseCase
abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Either<Failure, Type>> call(Params params);
}

/// Класс для случая отсутствия параметров
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class Param extends Equatable{
   const Param(this.cityName);
  final String cityName;
  @override
  List<Object?> get props => [];
}
