import 'dart:convert';

import 'package:bloc_auth/api/responses/login_response.dart';
import 'package:bloc_auth/api/responses/signup_response.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final String _BASE_URL = "http://10.0.2.2/api/";
  Dio _dio;
  ApiProvider() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 15000, connectTimeout: 15000);
    _dio = Dio(options);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      var header = {
        'content-type': 'application/json',
      };
      options.headers.addAll(header);
      return options;
    }));
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      Response<Map<String, dynamic>> response = await _dio.post(
          _BASE_URL + "signin",
          data: jsonEncode({"email": email, "password": password}));

      return LoginResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      return LoginResponse.withError(error.toString());
    }
  }

  Future<SignUpResponse> signup(
      String name, String email, String password) async {
    try {
      Response<Map<String, dynamic>> response = await _dio.post(
          _BASE_URL + "signup",
          data:
              jsonEncode({"name": name, "email": email, "password": password}));

      print("signup ${response.data}");
      return SignUpResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      return SignUpResponse.withError(error.toString());
    }
  }
}
