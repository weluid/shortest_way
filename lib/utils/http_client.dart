import 'dart:io';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  final _client = http.Client();

  ///add header params before sent rest message
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    request.headers['Accept'] = 'application/json';
    return _client.send(request);
  }
}
