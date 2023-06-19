import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_calory_calculator/widgets/common/custom_bottom_navigation_bar.dart';

class MeasurementsPage extends StatelessWidget {
  static const pageName = "/measurements-page";
  const MeasurementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("MEASUREMENTS PAGE"),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}
