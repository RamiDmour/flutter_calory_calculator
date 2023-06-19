import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/gradient_text.dart';
import 'package:gradient_borders/gradient_borders.dart';

class Selector extends StatefulWidget {
  final String initValue;
  final List<String> values;
  final Function(String value) onChange;
  final double spacing;
  const Selector({
    super.key,
    required this.values,
    required this.onChange,
    this.spacing = 10,
    required this.initValue,
  });

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  late String currentValue;

  @override
  void initState() {
    setState(() {
      currentValue = widget.initValue;
    });
    super.initState();
  }

  Widget _buildItem(String value, int index) {
    final isSelected = currentValue == value;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          currentValue = value;
          widget.onChange(currentValue);
        }),
        child: Container(
          padding: const EdgeInsets.all(2),
          margin: EdgeInsets.only(
            right: index != widget.values.length - 1 ? widget.spacing : 0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: !isSelected ? GradientBoxBorder(gradient: AppColors.primaryGradient) : null,
            gradient: isSelected ? AppColors.primaryGradient : null,
          ),
          child: Center(
            child: FittedBox(
              child: !isSelected
                  ? GradientText(
                      value,
                      gradient: AppColors.primaryGradient,
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.grey,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: widget.values
          .asMap()
          .entries
          .map(
            (entry) => _buildItem(entry.value, entry.key),
          )
          .toList(),
    );
  }
}
