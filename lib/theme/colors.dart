import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/utills/hex_color.dart';

class AppColors {
  static final primary = HexColor.fromHex("#17597D");
  static final grey = HexColor.fromHex("#B0B0B0");
  static final primaryGradient = LinearGradient(
    colors: [
      HexColor.fromHex("#13547A"),
      HexColor.fromHex("#80D0C7"),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static final black = HexColor.fromHex("#151515");
}
