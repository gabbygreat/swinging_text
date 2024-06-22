class Pagination {
  int page;
  int total;
  int size;

  Pagination({
    this.page = 0,
    this.total = 100,
    this.size = 50,
  });

  void reset() {
    page = 0;
    total = 100;
  }

  @override
  String toString() {
    return '''
Pagination(
  page: $page,
  total: $total,
  size: $size,
)''';
  }
}

class CustomError {
  final String? message;

  CustomError({
    required this.message,
  });

  factory CustomError.fromJson(Map<String, dynamic> data) {
    return CustomError(
      message: data['message'],
    );
  }
}
