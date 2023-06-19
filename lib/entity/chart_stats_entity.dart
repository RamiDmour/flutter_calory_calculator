class ChartStatsEntity {
  final DateTime date;
  final double caloryIntake;
  final double caloryBurned;
  final double proteins;
  final double fats;
  final double carbohydrates;
  final double water;

  ChartStatsEntity(
    this.caloryIntake,
    this.proteins,
    this.fats,
    this.carbohydrates,
    this.water,
    this.date,
    this.caloryBurned,
  );
}
