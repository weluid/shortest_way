import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuccessResponse {
  final bool success;
  final String? errors;

  const SuccessResponse.success({
    required this.success,
    required this.errors,
  });

  const SuccessResponse.error({
    required this.errors,
  }) : success = false;

  factory SuccessResponse.fromResponse(http.Response response) {
    try {
      final decoded = response.body.contains('{')
          ? jsonDecode(response.body) as Map<String, dynamic>
          : jsonDecode('{"error": "${response.body}"}') as Map<String, dynamic>;
      final isSuccess = response.statusCode <= 204;
      final error =
          decoded['error'] != null ? decoded['error']!.toString() : null;
      final message =
          decoded['message'] != null ? decoded['message']!.toString() : null;
      if (isSuccess) {
        return SuccessResponse.success(
          success: true,
          errors: error ?? message,
        );
      } else {
        return SuccessResponse.error(
          errors: decoded['error'],
        );
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return const SuccessResponse.error(errors: null);
    }
  }
}
