import '../utils.dart';

part 'view.dart';

class MvcScreen extends StatefulWidget {
  const MvcScreen({super.key});

  @override
  State<MvcScreen> createState() => MvcController();
}

class MvcController extends State<MvcScreen> {
  @override
  Widget build(BuildContext context) {
    return MvcView(this);
  }
}
