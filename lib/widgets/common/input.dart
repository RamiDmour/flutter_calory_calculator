import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:gradient_borders/gradient_borders.dart';

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholderText;
  final bool isPassword;
  final TextInputType keyboardType;
  final Function()? onTap;
  final Function(String? text)? onChanged;
  final Icon? suffixIcon;
  const Input({
    super.key,
    this.controller,
    required this.placeholderText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: !isPassword,
      obscureText: isPassword,
      controller: controller,
      textAlignVertical: TextAlignVertical.bottom,
      keyboardType: keyboardType,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(
          color: AppColors.grey,
        ),
        border: GradientOutlineInputBorder(
          width: 1,
          borderRadius: BorderRadius.circular(5),
          gradient: AppColors.primaryGradient,
        ),
        hintText: placeholderText,
      ),
    );
  }
}
