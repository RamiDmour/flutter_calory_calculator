import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';

class Button extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool isLoading;
  final double textSize;
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.textSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        gradient: AppColors.primaryGradient,
      ),
      child: MaterialButton(
        height: 50,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
