import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'core/app_logger/talker_logger.dart';
import 'core/dependencies/injection_container.dart';
import 'features/weather/weather/presentation/bloc/screens/weather_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Инициализация зависимостей
  await getInit();

  /// Инициализация логгера, первый лог
  getIt<ITalkerAppLogger>().log(
    level: LogLevel.verbose,
    message: 'Application started',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

