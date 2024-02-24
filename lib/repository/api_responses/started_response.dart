import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/started_data_model.dart';

class StartedDataResponse {
  final bool success;
  final String? errors;
  final List<StartedDataModel>? startedData;

  const StartedDataResponse.success({
    required this.success,
    required this.errors,
    required this.startedData,
  });

  const StartedDataResponse.error({
    required this.errors,
  })  : success = false,
        startedData = null;

  factory StartedDataResponse.fromJson(http.Response response) {
    try {
      final decoded = response.body.contains('{')
          ? jsonDecode(response.body) as Map<String, dynamic>
          : jsonDecode('{"error": "${response.body}"}') as Map<String, dynamic>;
      final isSuccess = response.statusCode <= 204;

      if (isSuccess) {
        List<StartedDataModel> imageList = (decoded["data"] as List)
            .map((data) => StartedDataModel.fromJson(data))
            .toList();
        return StartedDataResponse.success(
          success: true,
          errors: '',
          startedData: imageList,
        );
      } else {
        final decoded = response.body.contains('{')
            ? jsonDecode(response.body) as Map<String, dynamic>
            : jsonDecode('{"error": "${response.body}"}')
                as Map<String, dynamic>;

        final error =
            decoded['error'] != null ? decoded['error']!.toString() : null;
        final message =
            decoded['message'] != null ? decoded['message']!.toString() : null;
        return StartedDataResponse.error(
          errors: error ?? message,
        );
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return const StartedDataResponse.error(errors: null);
    }
  }
}
