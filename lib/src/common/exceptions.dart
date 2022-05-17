import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exceptions.freezed.dart';

@freezed
class NetworkException with _$NetworkException implements Exception {
  const factory NetworkException({
    required String message,
    int? statusCode,
    Object? response,
    StackTrace? stackTrace,
  }) = ServerException;

  /// Usually this exception indicates that a data was null or empty
  const factory NetworkException.noDataException() = NoDataException;

  const factory NetworkException.loadingDataException() = LoadingDataException;

  const NetworkException._();

  static NetworkException fromDioError(DioError error, {String? message}) {
    return NetworkException(
      statusCode: error.response?.statusCode,
      message: message ?? error.message,
      response: error.response?.data,
      stackTrace: error.stackTrace,
    );
  }

  String? get responseMessage {
    try {
      return maybeWhen(
            (message, statusCode, response, stackTrace) {
          final data = json.decode((response ?? '{}') as String) as Map?;
          final message = (data ?? <dynamic, dynamic>{})['error'] as String?;
          return message;
        },
        orElse: () => null,
      );
    } on Exception {
      return null;
    }
  }

  @override
  String toString() {
    return when(
          (message, statusCode, response, stackTrace) => 'NetworkException{statusCode: $statusCode, message: $message}',
      noDataException: () => 'NoDataException',
      loadingDataException: () => 'LoadingDataException',
    );
  }
}
