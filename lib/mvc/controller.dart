import 'package:learn/utils/utils.dart';

class CounterControllerMVC {
  final CounterModel _model;
  ValueNotifier<int> counterNotifier;

  CounterControllerMVC(this._model)
      : counterNotifier = ValueNotifier(_model.counter);

  int get counter => _model.counter;

  void increment() {
    _model.increment();
    counterNotifier.value = _model.counter;
  }

  void decrement() {
    _model.decrement();
    counterNotifier.value = _model.counter;
  }

  void dispose() {
    counterNotifier.dispose();
  }
}
