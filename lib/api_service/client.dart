
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:news_app/common/extensions.dart';

import '../common/exceptions.dart';
//connection settings
var options = BaseOptions(
  baseUrl: 'https://api.spaceflightnewsapi.net/v3',
  connectTimeout: 30000,
  receiveTimeout: 30000,
);

Dio dioClient = Dio(options);

Future<Either<NetworkException, dynamic>> dioGet(
    String path, {
      Map<String, dynamic>? query,
    }) async {
  return request(path, query: query, method: 'GET');
}

Future<Either<NetworkException, dynamic>> request(
    String path, {
      required String method,
      Map<String, dynamic>? query,
      Map<String, String>? headers,
      dynamic body,
    }) async {
  final result = rawRequest(
    path,
    query: query,
    body: body,
    method: method,
  );
  return result.map<dynamic>((r) => r.data).run();
}

@protected
TaskEither<NetworkException, Response> rawRequest(
    String path, {
      required String method,
      Map<String, dynamic>? query,
      Map<String, String>? headers,
      dynamic body,
    }) {
  final request = RequestOptions(
    path: dioClient.options.baseUrl + path,
    method: method,
    queryParameters: query,
    headers: headers,
    data: body,
  );
  return TaskEither<NetworkException, Response>(() async {
    try {
      final response = await dioClient.fetch<dynamic>(request);

      if ((response.data as Object?).isNullOrEmptyList) return const Left(NetworkException.noDataException());
      return Right(response);
    } catch (err, st) {
      log('error ${err.runtimeType} in NetworkService[$method][path]',
          error: err, stackTrace: st);
      if (err is DioError) {
        return Left(NetworkException.fromDioError(err));
      }
      return const Left(NetworkException(message: 'unknown'));
    }
  });
}