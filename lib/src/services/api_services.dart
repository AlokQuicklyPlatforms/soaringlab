import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:get_storage/get_storage.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'app_initializer.dart';

class ApiService {
  final Dio _dio = AppInitializer().dio;

  final GetStorage _storage = AppInitializer().storage;

  Future<Either<String, dynamic>> get(String endpoint,
      {bool needToken = false}) async {
    log("Request Get::: NeedToken: $needToken, URL: $endpoint,");
    try {
      _setAuthHeaderIfNeeded(needToken);
      _dio.options.connectTimeout=Duration(seconds: 10);

      final response = await _dio.get(endpoint);

      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<String, dynamic>> postBody(String endpoint, var body,
      {bool needToken = false}) async {
    log("Request PostBody::: NeedToken: $needToken, URL: $endpoint, Body: $body");
    try {
      _setAuthHeaderIfNeeded(needToken);

      final response = await _dio.post(endpoint, data: body);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<String, dynamic>> delete(String endpoint,
      {bool needToken = false}) async {
    try {
      _setAuthHeaderIfNeeded(needToken);

      final response = await _dio.delete(endpoint);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<String, dynamic>> postFormData(
      String endpoint, Map<String, dynamic> formData,
      {bool needToken = false}) async {
    log("Request PostFormData::: NeedToken: $needToken, URL: $endpoint, Body: $formData");
    try {
      _setAuthHeaderIfNeeded(needToken);
      FormData data = FormData.fromMap(formData);
      final response = await _dio.post(endpoint, data: data);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  void _setAuthHeaderIfNeeded(bool needToken) {
    if (needToken) {
      String? token = authstoragebox.get('token');
      log("token :::$token");
      if (token != null) {
        _dio.options.headers = {
          'Content-Type': 'application/json',
          'token': token,
        };

        // _dio.options.headers['Authorization'] = 'Bearer $token';
      }
    }
  }

  String _handleError(DioException error) {
    if (error.response != null) {
      // Server error
      return 'Error: ${error.response?.statusMessage}, Data: ${error.response?.data}';
    } else {
      // Other errors (network, timeout, etc)
      return 'Error: ${error.message}';
    }
  }

  Future<Either<String, dynamic>> getresponse(String endpoint,
      {String? email, bool needToken = false}) async {
    // log("Request Get::: NeedToken: $needToken, URL: $endpoint, Email: $email");

    try {
      _setAuthHeaderIfNeeded(needToken);

      // Create a map for query parameters
      final Map<String, String> queryParams = {};
      if (email != null) {
        queryParams['email'] = email;
      }

      // Make the GET request with query parameters
      final response = await _dio.get(endpoint, queryParameters: queryParams);

      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }
}
