import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:leet_tutur/constants/api_constants.dart';
import 'package:leet_tutur/constants/shared_preferences_constants.dart';
import 'package:leet_tutur/models/responses/auth_response.dart';
import 'package:leet_tutur/models/tokens.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUtils {
  static Dio constructDio() {
    final dio = Dio()
      ..options.baseUrl = ApiConstants.baseURL
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        maxWidth: 120,
        compact: true,
      ));

    return dio;
  }

  static Future<Tokens> getTokensAsync() async {
    final prefs = await SharedPreferences.getInstance();
    var jsonString =
        prefs.getString(SharedPreferencesConstants.authResponse) ?? "{}";

    var authRes = AuthResponse.fromJson(jsonDecode(jsonString));

    return authRes.tokens ?? Tokens();
  }

  static Future<String> getBearerTokenAsync() async {
    var tokens = await getTokensAsync();

    return "Bearer ${tokens.access?.token}";
  }
}