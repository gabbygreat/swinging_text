import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/utils.dart';
part 'view.dart';

class PlaneScreen extends StatefulWidget {
  static const path = "/planes";
  static const name = "planes";
  const PlaneScreen({super.key});

  @override
  State<PlaneScreen> createState() => PlaneController();
}

class PlaneController extends State<PlaneScreen> {
  late RefreshController refreshController;
  late FutureSignal<List<AirPlaneModel>> airplaneSignal;
  ValueNotifier<List<AirPlaneModel>> airplaneHolder = ValueNotifier([]);
  Pagination pagination = Pagination();
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    airplaneSignal = futureSignal(
      () => PlaneRequest.instance.fetchPlanes(pagination: pagination),
    );
  }

  void onLoading() async {
    try {
      if (airplaneHolder.value.length == pagination.total) {
        refreshController.loadNoData();
      } else {
        var a = await PlaneRequest.instance.fetchPlanes(pagination: pagination);
        airplaneHolder.value = [...a];
        refreshController.loadComplete();
      }
    } catch (_) {
      refreshController.refreshFailed();
    }
  }

  void onRefresh() async {
    pagination.reset();
    try {
      var a = await PlaneRequest.instance.fetchPlanes(pagination: pagination);
      airplaneHolder.value = [...a];
      refreshController.refreshCompleted(resetFooterState: true);
    } catch (_) {
      refreshController.refreshFailed();
    }
  }

  @override
  void dispose() {
    refreshController.dispose();
    airplaneSignal.dispose();
    airplaneHolder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaneView(this);
  }
}
