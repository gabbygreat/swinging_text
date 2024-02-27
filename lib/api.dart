import 'dart:io';

import 'package:dio/dio.dart';
import 'package:learn/model.dart';

Future<List<Feeds>> getContents({
  required Pagination pagination,
}) async {
  // TODO replace with your URL
  var path = 'https://<your url>/${pagination.size}/${pagination.page}';
  var dio = Dio();
  var request = await dio.get(path,
      options: Options(headers: {
        HttpHeaders.authorizationHeader:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODIwNSwidG9rZW4iOiI4OTRlMzQ0M2I2M2M5MjkzIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MDkwNTg2ODd9.EmEHju_QGR95V9ztv3VYx1IKXOZeyvoWnu9ToloiFeo'
      }));
  pagination.total = request.data['data']['totalCount'];
  pagination.page += 1;
  return (request.data['data']['posts'] as List)
      .map((e) => Feeds.fromJson(e))
      .toList();
}
