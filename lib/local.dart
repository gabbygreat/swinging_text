import 'package:objectbox/objectbox.dart';

@Entity()
class LocalFeeds {
  @Id(assignable: true)
  int id;
  String displayName;
  String? displayPhoto;
  String placeName;
  String text;

  final media = ToOne<LocalMedia>();

  LocalFeeds({
    required this.displayName,
    required this.displayPhoto,
    required this.placeName,
    required this.text,
    required this.id, // Assign a unique ID when creating a new feed
  });
}

@Entity()
class LocalMedia {
  @Id()
  int id;
  String url;
  String type;
  double width;
  double height;
  String? thumbnail;

  // Define a back-link to the parent LocalFeeds object
  final feeds = ToOne<LocalFeeds>();

  LocalMedia({
    required this.id,
    required this.url,
    required this.type,
    required this.width,
    required this.height,
    required this.thumbnail,
  });
}
