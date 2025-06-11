// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:pinntag/api/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HttpMethod { GET, POST, PUT, DELETE }

enum ResponseType { json, bool }

class ApiService extends GetxService {
  late dio.Dio _dio;
  final String baseUrl = Endpoints.baseUrl;
  final Rx<String?> _token = Rx<String?>(null);

  String? get token => _token.value;

  static ApiService get to => Get.put(ApiService());

  @override
  void onInit() {
    super.onInit();
    _initializeDio();
  }

  void _initializeDio() {
    final options = dio.BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
      validateStatus: (status) => status != null && status < 500,
    );

    _dio = dio.Dio(options);
    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      dio.LogInterceptor(
        request: kDebugMode,
        requestHeader: kDebugMode,
        requestBody: kDebugMode,
        responseHeader: kDebugMode,
        responseBody: kDebugMode,
        error: kDebugMode,
        logPrint: (object) => debugPrint(object.toString()),
      ),
    );

    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token.value != null) {
            options.headers['Authorization'] = 'Bearer ${_token.value}';
          }

          if (options.data is dio.FormData) {
            options.contentType = 'multipart/form-data';
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (dio.DioException error, handler) {
          return handler.next(error); // Let error handler deal with it
        },
      ),
    );
  }

  void clearToken() {
    _token.value = null;
  }

  Future<dynamic> request(
    HttpMethod method, {
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    ResponseType responseType = ResponseType.json,
  }) async {
    try {
      final options = dio.Options();

      final prefs = await SharedPreferences.getInstance();
      String? storedToken = prefs.getString('token');
      if (storedToken != null) {
        _token.value = storedToken;
      }

      dio.Response response;

      switch (method) {
        case HttpMethod.GET:
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.POST:
          response = await _dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.PUT:
          response = await _dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.DELETE:
          response = await _dio.delete(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
      }

      final dynamic responseData =
          response.data is String ? json.decode(response.data) : response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseData;
      } else if (response.statusCode == 400) {
        final errorMsg = _extractErrorMessage(responseData);
        throw Exception(errorMsg);
      } else {
        final errorMsg = _extractErrorMessage(responseData);
        throw Exception(errorMsg);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  dynamic _handleError(dynamic error) {
    if (error is dio.DioException) {
      final errorMessage = _getErrorMessage(error);
      throw Exception(errorMessage);
    } else if (error is Exception) {
      throw error;
    } else {
      throw Exception('Unknown error occurred');
    }
  }

  String _getErrorMessage(dio.DioException error) {
    String errorMessage = 'Something went wrong. Please try again later.';

    switch (error.type) {
      case dio.DioExceptionType.connectionTimeout:
      case dio.DioExceptionType.sendTimeout:
      case dio.DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case dio.DioExceptionType.badResponse:
        final data = error.response?.data;
        final status = error.response?.statusCode;

        if (status == 400 && data is Map && data.containsKey('message')) {
          return data['message'];
        } else if (data is Map && data.containsKey('error')) {
          return data['error'];
        }
        break;
      case dio.DioExceptionType.cancel:
        return 'Request cancelled';
      case dio.DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return errorMessage;
    }

    return errorMessage;
  }

  String _extractErrorMessage(dynamic responseData) {
    if (responseData is Map && responseData.containsKey('message')) {
      return responseData['message'];
    }
    return 'Bad Request';
  }
}
