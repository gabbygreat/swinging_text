import 'package:learn/local.dart';
import 'package:learn/model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-post"));
    return ObjectBox._create(store);
  }

  void storePost(Feeds feed) {
    final userBox = store.box<LocalFeeds>();
    var localPostLength = userBox.getAll().length;
    if (localPostLength <= 4) {
      var localFeed = LocalFeeds(
        displayName: feed.displayName,
        displayPhoto: feed.displayPhoto,
        placeName: feed.placeName,
        text: feed.text,
        id: feed.id,
      );
      LocalMedia media = LocalMedia(
        id: 0,
        url: feed.media.first.url,
        type: feed.media.first.type,
        width: feed.media.first.width.toDouble(),
        height: feed.media.first.height.toDouble(),
        thumbnail: feed.media.first.thumbnail,
      );
      localFeed.media.target = media;
      userBox.put(localFeed);
    }
  }

  void clearStorage() {
    final userBox = store.box<LocalFeeds>();
    userBox.removeAllAsync();
  }

  List<Feeds> fetchPost(Pagination pagination) {
    final userBox = store.box<LocalFeeds>();
    var allPosts = userBox.getAll();
    pagination.total = allPosts.length;
    return allPosts
        .map(
          (e) => Feeds(
            id: e.id,
            displayName: e.displayName,
            displayPhoto: e.displayPhoto,
            placeName: e.displayName,
            text: e.text,
            media: [
              Media(
                  url: e.media.target!.url,
                  type: e.media.target!.type,
                  width: e.media.target!.width,
                  height: e.media.target!.height,
                  thumbnail: e.media.target!.thumbnail)
            ],
          ),
        )
        .toList();
  }
}
