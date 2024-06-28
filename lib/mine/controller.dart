import '../../utils/utils.dart';
part 'view.dart';

class CounterScreen extends StatefulWidget {
  static const path = "/Counters";
  static const name = "Counters";

  final CounterModel model;
  const CounterScreen({
    super.key,
    required this.model,
  });

  @override
  State<CounterScreen> createState() => CounterController();
}

class CounterController extends State<CounterScreen> {
  late ValueNotifier<int> counterNotifier;

  @override
  void initState() {
    super.initState();
    counterNotifier = ValueNotifier(widget.model.counter);
  }

  void increment() {
    widget.model.increment();
    counterNotifier.value = widget.model.counter;
  }

  void decrement() {
    widget.model.decrement();
    counterNotifier.value = widget.model.counter;
  }

  @override
  void dispose() {
    counterNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CounterView(this);
  }
}
