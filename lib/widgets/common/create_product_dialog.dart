import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/models/product.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/input.dart';
import 'package:get/get.dart';

class CreateProductDialog extends StatefulWidget {
  final Function(Product product) onSave;
  final Function() onDecline;

  const CreateProductDialog({
    super.key,
    required this.onSave,
    required this.onDecline,
  });
  @override
  State<CreateProductDialog> createState() => _CreateProductDialogState();
}

class _CreateProductDialogState extends State<CreateProductDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController caloryController = TextEditingController();
  final TextEditingController proteinsController = TextEditingController();
  final TextEditingController fatsController = TextEditingController();
  final TextEditingController carbohydratesController = TextEditingController();

  onSave() {
    try {
      widget.onSave(Product(
        id: 0,
        name: nameController.text,
        calory: double.parse(caloryController.text),
        proteins: double.parse(proteinsController.text),
        fats: double.parse(fatsController.text),
        carbohydrates: double.parse(carbohydratesController.text),
      ));
    } catch (e) {
      printError(info: e.toString());
    }
  }

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
              const Text(
                "Добавить  продукт",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Input(
                placeholderText: "Название",
                controller: nameController,
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: Input(
                placeholderText: "Калорий в 100 грамм",
                controller: caloryController,
              )),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: Input(
                    placeholderText: "Б",
                    controller: proteinsController,
                  )),
                  const SizedBox(width: 5),
                  Expanded(
                      child: Input(
                    placeholderText: "Ж",
                    controller: fatsController,
                  )),
                  const SizedBox(width: 5),
                  Expanded(
                      child: Input(
                    placeholderText: "У",
                    controller: carbohydratesController,
                  )),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: widget.onDecline,
                    child: const Text(
                      "Отменить",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
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
                        fontSize: 18,
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

  @override
  void dispose() {
    caloryController.dispose();
    nameController.dispose();
    fatsController.dispose();
    proteinsController.dispose();
    carbohydratesController.dispose();
    super.dispose();
  }
}
