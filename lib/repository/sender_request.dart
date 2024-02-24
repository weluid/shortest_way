import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shortest_way/utils/http_client.dart';

class SenderRequest {
  static final _singleton = SenderRequest._internal();

  factory SenderRequest() => _singleton;

  SenderRequest._internal();

  final _client = HttpClient();

  void _handleHttpError({required String method, required Uri route, error}) {
    try {
      if (error?.message != null) {
        debugPrint('ERROR: $method $route\n${error?.message}');
      }
    } catch (exception, stackTrace) {
      debugPrint('HTTP ERROR HANDLING ERROR: $exception');
      debugPrint(stackTrace.toString());
    }
  }

  void _printResponse(http.Response? response) {
    try {
      debugPrint(response?.request.toString() ?? '');
      debugPrint(response?.statusCode.toString() ?? '');
      try {
        debugPrint(jsonDecode(response?.body.toString() ?? '').toString());
      } catch (e) {
        debugPrint(response?.body.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  T? parsedResponse<T>(
    http.Response? response, {
    required Function? onSuccess,
    required Function? onError,
  }) {
    _printResponse(response);
    if (response == null) {
      return null;
    } else if (response.statusCode <= 205) {
      return onSuccess == null ? null : onSuccess(response);
    } else if (response.statusCode == 401) {
      //App.globalContext.read<AuthBloc>().add(const LogOutEvent(needApi: false));
      return null;
    } else {
      return onError == null ? null : onError(response);
    }
  }

  Future<http.Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    if (queryParameters != null) {
      queryParameters.removeWhere((k, v) => v == null);
      queryParameters.forEach((k, v) {
        if (v is! String) queryParameters?[k] = v.toString();
      });
      if (queryParameters.isEmpty) {
        queryParameters = null;
      }
    }
    final route = Uri.parse(url);
    log(route.toString());
    try {
      return await _client.get(route, headers: headers);
    } catch (error) {
      _handleHttpError(method: 'GET', route: route, error: error);
      return null;
    }
  }

  Future<http.Response?> post(
    String url, {
  List<Map<String, dynamic>>? body,
    String? rawBody,
    bool? hasLists,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {

    if (queryParameters != null) {
      queryParameters.removeWhere((k, v) => v == null);
      queryParameters.forEach((k, v) {
        if (v is! String) queryParameters?[k] = v.toString();
      });
      if (queryParameters.isEmpty) {
        queryParameters = null;
      }
    }
    final route = Uri.parse(url);
    try {
      var response = await _client.post(
        route,
        body: (body?.isNotEmpty ?? false) ? jsonEncode(body) : rawBody,
        headers: headers,
      );

      print(response.statusCode);
      return response;
    } catch (error) {
      _handleHttpError(method: 'POST', route: route, error: error);
      return null;
    }
  }
}
