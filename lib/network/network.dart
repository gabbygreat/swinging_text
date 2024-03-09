import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class NetworkService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.tonguesservices.com/prod/',
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  NetworkService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          var token = 'f3d9aef9-fb40-4993-97b4-0274aaf75afa';
          options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
          options.headers['X-API-Key'] = token;

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            try {
              // Refresh token
              var response = await _dio.request(
                e.requestOptions.path,
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
                options: Options(
                  method: e.requestOptions.method,
                  headers: e.requestOptions.headers,
                ),
              );
              return handler.resolve(response);
            } catch (_) {
              // Logout
            }
          }
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
    final a = await _dio.get(
      path,
      options: options,
      queryParameters: queryPatameters,
      data: data,
      cancelToken: cancelToken,
    );
    log(a.data.toString());
    return a;
  }

  Future<Response> postRequestHandler(
    String path, {
    Object? data,
    Map<String, dynamic>? queryPatameters,
    Options? options,
    bool? deviceToken,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    final a = await _dio.post(
      path,
      data: data,
      queryParameters: queryPatameters,
      options: options,
      cancelToken: cancelToken,
    );
    log(a.data.toString());
    return a;
  }

  Future<Response> patchRequestHandler(
    String path, {
    Object? data,
    Map<String, dynamic>? queryPatameters,
    Options? options,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    final a = await _dio.patch(
      path,
      cancelToken: cancelToken,
      data: data,
      queryParameters: queryPatameters,
      options: options,
    );
    log(a.data.toString());
    return a;
  }

  Future<Response> deleteRequestHandler(
    String path, {
    Object? data,
    Map<String, dynamic>? queryPatameters,
    Options? options,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    final a = await _dio.delete(
      path,
      cancelToken: cancelToken,
      data: data,
      queryParameters: queryPatameters,
      options: options,
    );
    log(a.data.toString());
    return a;
  }
}
