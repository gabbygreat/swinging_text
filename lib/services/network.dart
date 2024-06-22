import 'dart:developer';
import 'package:flutter/foundation.dart';

import '../utils/utils.dart';

abstract class NetworkService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstant.baseUrl,
    ),
  );

  NetworkService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            log(response.data.toString());
          }
          return handler.next(response);
        },
        onError: (e, handler) async {
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> getRequestHandler(
    String path, {
    Options? options,
    Object? data,
    Map<String, dynamic>? queryPatameters,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    String uri = '${AppConstant.baseUrl}/$path';
    if (!useBaseUrl) {
      uri = path;
    }
    final a = await _dio.get(
      uri,
      options: options,
      queryParameters: queryPatameters,
      data: data,
      cancelToken: cancelToken,
    );
    return a;
  }

  Future<Response> postRequestHandler(
    String path, {
    Options? options,
    Object? data,
    Map<String, dynamic>? queryPatameters,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    String uri = '${AppConstant.baseUrl}/$path';
    if (!useBaseUrl) {
      uri = path;
    }
    final a = await _dio.post(
      uri,
      options: options,
      queryParameters: queryPatameters,
      data: data,
      cancelToken: cancelToken,
    );
    debugPrint(a.data.toString());
    return a;
  }

  Future<Response> patchRequestHandler(
    String path, {
    Options? options,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryPatameters,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    String uri = '${AppConstant.baseUrl}/$path';
    if (!useBaseUrl) {
      uri = path;
    }
    final a = await _dio.patch(
      uri,
      options: options,
      queryParameters: queryPatameters,
      data: data,
      cancelToken: cancelToken,
    );
    debugPrint(a.data.toString());
    return a;
  }

  Future<Response> deleteRequestHandler(
    String path, {
    Options? options,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryPatameters,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    String uri = '${AppConstant.baseUrl}/$path';
    if (!useBaseUrl) {
      uri = path;
    }
    final a = await _dio.delete(
      uri,
      options: options,
      queryParameters: queryPatameters,
      data: data,
      cancelToken: cancelToken,
    );
    debugPrint(a.data.toString());
    return a;
  }

  Future<Response> putRequestHandler(
    String path, {
    Options? options,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryPatameters,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    String uri = '${AppConstant.baseUrl}/$path';
    if (!useBaseUrl) {
      uri = path;
    }
    final a = await _dio.put(
      uri,
      options: options,
      queryParameters: queryPatameters,
      data: data,
      cancelToken: cancelToken,
    );
    debugPrint(a.data.toString());
    return a;
  }
}
