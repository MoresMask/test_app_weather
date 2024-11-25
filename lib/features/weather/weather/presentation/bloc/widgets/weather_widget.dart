import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_weather/features/weather/_common/domain/entity/weather_entity.dart';

import '../../../../../../core/constants/app_constants.dart';

/// [WeatherItemWidget] - виджет для отображения погоды
class WeatherItemWidget extends StatelessWidget {
  const WeatherItemWidget({
    super.key,
    required this.weather,
  });

  /// Погода
  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) => Container(
    padding: AppConstants.kPaddingH20,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: AppConstants.kBorderRadius20,
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(weather.location?.name ?? "")),
            Text(weather.current?.dewpointC.toString() ?? ""),
          ],
        ),
        AppConstants.kBoxH16,
        Row(
          children: [
            Text(weather.location?.name ?? ""),
            Text(weather.location?.name ?? ""),
          ],
        ),
      ],
    ),
  );
}
