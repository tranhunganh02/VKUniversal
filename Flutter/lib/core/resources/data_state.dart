import 'dart:io';

import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}

DataFailed handleHttpStatusError(int statusCode) {
  RequestOptions options = RequestOptions();

  switch (statusCode) {
    case HttpStatus.unauthorized:
      return DataFailed(DioException(
        requestOptions: options,
        error: 'Unauthorized: Access token might be expired or invalid.',
        response: Response(
          requestOptions: options,
          statusCode: statusCode,
          statusMessage: 'Unauthorized',
        ),
      ));
    case HttpStatus.badRequest:
      return DataFailed(DioException(
        requestOptions: options,
        error: 'Bad Request: The request was invalid or cannot be served.',
        response: Response(
          requestOptions: options,
          statusCode: statusCode,
          statusMessage: 'Bad Request',
        ),
      ));
    case HttpStatus.forbidden:
      return DataFailed(DioException(
        requestOptions: options,
        error: 'Forbidden: Access is denied.',
        response: Response(
          requestOptions: options,
          statusCode: statusCode,
          statusMessage: 'Forbidden',
        ),
      ));
    case HttpStatus.notFound:
      return DataFailed(DioException(
        requestOptions: options,
        error: 'Not Found: The requested resource could not be found.',
        response: Response(
          requestOptions: options,
          statusCode: statusCode,
          statusMessage: 'Not Found',
        ),
      ));
    case HttpStatus.internalServerError:
      return DataFailed(DioException(
        requestOptions: options,
        error: 'Internal Server Error: The server encountered an error.',
        response: Response(
          requestOptions: options,
          statusCode: statusCode,
          statusMessage: 'Internal Server Error',
        ),
      ));
    default:
      return DataFailed(DioException(
        requestOptions: options,
        error: 'HTTP Error: Status code $statusCode',
        response: Response(
          requestOptions: options,
          statusCode: statusCode,
          statusMessage: 'HTTP Error',
        ),
      ));
  }
}
