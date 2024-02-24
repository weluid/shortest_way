import 'package:shortest_way/repository/api_responses/started_response.dart';

import '../sender_request.dart';

class StartedRequest {
  /// get started data from server
  Future<StartedDataResponse?> getStartedData(String url) async {
    final response = await SenderRequest().get(url);
    return SenderRequest().parsedResponse<StartedDataResponse>(
      response,
      onSuccess: (r) => StartedDataResponse.fromJson(r),
      onError: (r) => StartedDataResponse.fromJson(r),
    );
  }
}
