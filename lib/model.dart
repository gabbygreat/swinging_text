class Feeds {
  int id;
  String displayName;
  String? displayPhoto;
  String placeName;
  String text;
  List<Media> media;

  Feeds({
    required this.displayName,
    required this.displayPhoto,
    required this.placeName,
    required this.text,
    required this.media,
    required this.id,
  });

  factory Feeds.fromJson(Map<String, dynamic> json) => Feeds(
        id: json["postId"],
        displayName: json["displayName"],
        displayPhoto: json["displayPhoto"],
        placeName: json["placeName"],
        text: json["text"] ?? json["description"] ?? "",
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );
}

class Media {
  String url;
  String type;
  num width;
  num height;
  String? thumbnail;

  Media({
    required this.url,
    required this.type,
    required this.width,
    required this.height,
    required this.thumbnail,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        url: json["url"],
        type: json["type"],
        width: num.parse(json["width"]),
        height: num.parse(json["height"]),
        thumbnail: json["thumbnail"],
      );
}

class Pagination {
  int page;
  int total;
  int size;
  String? path;

  Pagination({
    this.page = 1,
    this.total = 100,
    this.size = 20,
    this.path,
  });
}
