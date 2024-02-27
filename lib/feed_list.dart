import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/api.dart';
import 'package:learn/feed_card.dart';
import 'package:learn/main.dart';
import 'package:learn/model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedsWidget extends ConsumerStatefulWidget {
  const FeedsWidget({super.key});

  @override
  ConsumerState<FeedsWidget> createState() => _BooksState();
}

class _BooksState extends ConsumerState<FeedsWidget> {
  Pagination pagination = Pagination();
  late RefreshController refreshController;
  late FutureProviderFamily<List<Feeds>, Pagination> postProvider;
  ValueNotifier<List<Feeds>> feedList = ValueNotifier([]);
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    postProvider = FutureProvider.family((ref, Pagination pagination) async {
      var localPosts = objectbox.fetchPost(pagination);
      if (localPosts.isNotEmpty) {
        Future.delayed(const Duration(seconds: 3), () {
          objectbox.clearStorage();
          refreshController.requestRefresh();
        });
        return localPosts;
      } else {
        return getContents(pagination: pagination);
      }
    });
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var posts = ref.watch(postProvider(pagination));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Caching"),
      ),
      body: posts.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          if (!_loaded) {
            feedList.value = data.toList();
          }
          _loaded = true;
          return ValueListenableBuilder(
            valueListenable: feedList,
            builder: (context, list, _) {
              return SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                onLoading: () async {
                  if (data.length != pagination.total) {
                    try {
                      var a = await getContents(
                        pagination: pagination,
                      );
                      data.addAll(a);
                      feedList.value = data.toList();
                      refreshController.loadComplete();
                    } catch (_) {
                      refreshController.loadFailed();
                    }
                  } else {
                    refreshController.loadNoData();
                    return;
                  }
                },
                onRefresh: () async {
                  data.clear();
                  pagination.page = 1;
                  try {
                    var a = await getContents(pagination: pagination);
                    data.addAll(a);
                    feedList.value = data.toList();
                    ();
                    refreshController.refreshCompleted(resetFooterState: true);
                  } catch (_) {
                    refreshController.refreshFailed();
                  }
                },
                child: list.isEmpty
                    ? const Center(
                        child: Text(
                          'Nothing to see here',
                        ),
                      )
                    : ListView.separated(
                        itemCount: list.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemBuilder: (context, index) {
                          return FeedCard(
                            post: list[index],
                            refreshController: refreshController,
                          );
                        },
                      ),
              );
            },
          );
        },
        error: (error, trace) {
          return ElevatedButton(
            onPressed: () => ref.invalidate(postProvider(pagination..page = 1)),
            child: const Text("Reload"),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
