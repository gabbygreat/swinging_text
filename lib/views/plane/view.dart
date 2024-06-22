part of 'controller.dart';

class PlaneView extends StatelessView<PlaneScreen, PlaneController> {
  const PlaneView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final airplanes = controller.airplaneSignal.watch(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Planes',
        ),
      ),
      body: airplanes.map(
        data: (value) {
          if (!controller.loaded) {
            controller.loaded = true;
            controller.airplaneHolder.value = value.toList();
          }
          return ValueListenableBuilder(
            valueListenable: controller.airplaneHolder,
            builder: (context, data, _) {
              return SmartRefresher(
                controller: controller.refreshController,
                enablePullUp: true,
                onLoading: controller.onLoading,
                onRefresh: controller.onRefresh,
                child: data.isEmpty
                    ? const EmptyScreen()
                    : ListView.separated(
                        padding: const EdgeInsets.only(top: 20),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var item = data[index];
                          return ListTile(
                            title: Text(item.name),
                            leading: Image.network(
                              item.airlineModel.logo,
                            ),
                            subtitle: Text(
                              item.airlineModel.country,
                            ),
                          );
                        },
                      ),
              );
            },
          );
        },
        error: (error, trace) {
          return ErrorScreen(
            error: error,
            signal: controller.airplaneSignal,
            trace: trace,
          );
        },
        loading: () {
          return const CustomLoader();
        },
        reloading: () {
          return const CustomLoader();
        },
      ),
    );
  }
}
