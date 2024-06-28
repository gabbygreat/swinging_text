import 'package:learn/utils/utils.dart';

class CounterViewModel extends ValueNotifier<CounterModel> {
  final CounterModel _model;

  CounterViewModel(this._model) : super(_model);

  int get counter => _model.counter;

  void increment() {
    _model.increment();
    notifyListeners();
  }

  void decrement() {
    _model.decrement();
    notifyListeners();
  }
}
