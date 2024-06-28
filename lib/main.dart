import 'package:learn/mine/controller.dart';
import 'package:learn/mvc/controller.dart';
import 'package:learn/mvc/view.dart';
import 'package:learn/mvvm/view.dart';
import 'package:learn/mvvm/viewmodel.dart';

import 'utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AutomaticKeepAliveClientMixin {
  var model = CounterModel();
  late CounterControllerMVC controller = CounterControllerMVC(model);
  late CounterViewModel counterViewModel = CounterViewModel(model);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Planes',
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: 'MVVM',
              ),
              Tab(
                text: 'MVC',
              ),
              Tab(
                text: 'Mine',
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              CounterView1(
                viewModel: counterViewModel,
              ),
              CounterView2(
                controller: controller,
              ),
              CounterScreen(
                model: model,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
