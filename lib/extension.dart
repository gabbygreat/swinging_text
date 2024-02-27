extension WidgetExtensions on List<num> {
  double get getMax {
    return reduce((value, element) => value > element ? value : element)
        .toDouble();
  }
}
