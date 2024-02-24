import 'package:shortest_way/repository/sender_request.dart';

import '../api_responses/success_response.dart';

class AnswerRequest {
  /// post resul value to server
  Future<SuccessResponse?> postAnswer(
    String url,
    List<Map<String, dynamic>> allAnswers,
  ) async {
    final response = await SenderRequest().post(url, body: allAnswers);
    return SenderRequest().parsedResponse<SuccessResponse>(
      response,
      onSuccess: (r) => SuccessResponse.fromResponse(r),
      onError: (r) => SuccessResponse.fromResponse(r),
    );
  }
}
