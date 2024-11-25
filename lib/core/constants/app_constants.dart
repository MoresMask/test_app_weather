import 'package:flutter/material.dart';

/// [AppConstants] - класс содержащий константы приложения
abstract class AppConstants {
  //* ---------- Insets ---------- *//
  static const kPaddingH20 = EdgeInsets.symmetric(horizontal: 20);

  //* ---------- Boxes ---------- *//
  static const kBoxH16 = SizedBox(height: 16);
  static const kBoxH32 = SizedBox(height: 32);

  static const kBoxW12 = SizedBox(width: 12);

  //* ---------- Borders ---------- *//
  static const kBorderRadius20 = BorderRadius.all(Radius.circular(20));
}
