import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final DateTime date;
  final double value;

  ChartData(this.date, this.value);
}

class Chart extends StatelessWidget {
  final String title;
  final List<ChartData> data;
  const Chart({
    super.key,
    required this.data,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: title),
      primaryXAxis: CategoryAxis(),
      series: [
        LineSeries(
          dataSource: data,
          enableTooltip: true,
          isVisibleInLegend: true,
          sortingOrder: SortingOrder.descending,
          color: AppColors.primary,
          xValueMapper: (chartDataValue, i) => DateFormat('EEEE', 'ru').format(chartDataValue.date),
          yValueMapper: (chartDataValue, i) => chartDataValue.value,
        )
      ],
    );
  }
}
