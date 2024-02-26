// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'model.dart';

Future<User> getUser() async {
  var path = "https://random-data-api.com/api/v2/users";

  var dio = Dio();
  var request = await dio.get(path);
  return User.fromJson(request.data);
}

Future<User> getUser1() async {
  var path = "https://random-data-api.com/api/v2/users";

  var dio = Dio();
  var request = await dio.get(path);
  if (request.statusCode == 200) {
    return User.fromJson(request.data);
  } else {
    throw Exception();
  }
}

Future<User> getUser2(BuildContext context) async {
  var path = "https://random-data-api.com/api/v2/users";

  var dio = Dio();
  var request = await dio.get(path);
  try {
    if (request.statusCode == 200) {
      return User.fromJson(request.data);
    } else {
      throw Exception();
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('No Internet Connection')));
    throw const SocketException('No internet');
  }
}
