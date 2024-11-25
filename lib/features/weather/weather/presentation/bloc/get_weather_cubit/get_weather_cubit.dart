import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/base/usecase.dart';
import '../../../domain/use_case/get_weather_use_case.dart';
import 'get_weather_state.dart';

/// Cubit для получения Погоды
class GetWeatherCubit extends Cubit<GetWeatherState> {
  GetWeatherCubit(this._getWeatherUseCase) : super(GetWeatherStateInitial());

  /// UseCase для получения списка Погоды
  final GetWeatherUseCase _getWeatherUseCase;

  /// Получить список Погоды
  Future<void> getWeather(String cityName) async {
    /// Показать состояние загрузки
    emit(GetWeatherStateLoading());
    /// Выполнить UseCase
    await _getWeatherUseCase(Param(cityName)).fold(
      /// Обработать ошибку
          (failure) => emit(GetWeatherStateError()),

      /// Обработать успешный результат
          (weather) => emit(GetWeatherStateSuccess().copyWith(weather: weather)),
    );
  }
}
