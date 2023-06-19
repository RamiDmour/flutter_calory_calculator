import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/input.dart';
import 'package:get/get.dart';

class InputDialog extends StatelessWidget {
  final Function() onSave;
  final Function() onDecline;
  final String titleText;
  final Function(String? text) onChanged;
  final String placeholderText;

  const InputDialog({
    super.key,
    required this.onSave,
    required this.onDecline,
    required this.titleText,
    required this.onChanged,
    required this.placeholderText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: Get.width * 0.8,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Text(
                titleText,
                style: const TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 20,
                  bottom: 40,
                ),
                child: Input(
                  placeholderText: placeholderText,
                  onChanged: onChanged,
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: onDecline,
                    child: const Text(
                      "Отменить",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: onSave,
                    child: const Text(
                      "Сохранить",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
