import 'dart:io';

Map<String, String> getHeader([String token]) {
  Map<String, String> header = {};
  header[HttpHeaders.acceptHeader] = 'application/json';
  header[HttpHeaders.contentTypeHeader] = 'application/json';
  if(token != null) {
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }
  return header;
}
