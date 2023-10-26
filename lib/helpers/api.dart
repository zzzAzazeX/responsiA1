import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:responsi1/helpers/user_info.dart';
import 'app_exception.dart';

class Api {
  Future<dynamic> post(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          body: data,
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // Future<dynamic> put(dynamic url, dynamic data) async {
  //   var token = await UserInfo().getToken();
  //   var responseJson;
  //   try {
  //     final response = await http.put(
  //       Uri.parse(url),
  //       body: data,
  //       headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  //     );
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  // Future<dynamic> put(dynamic url, dynamic data) async {
  //   var token = await UserInfo().getToken();
  //   var responseJson;
  //   print("datanya adalah : \n $data");
  //   try {
  //     final response = await http.put(Uri.parse(url),
  //         headers: {"Content-Type": "application/json"}, body: data);
  //     responseJson = _returnResponse(response);
  //     print("HTTP Status Code: ${response.statusCode}");
  //     print("Response Body: ${response.body}");
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  // Future<dynamic> put(dynamic url, dynamic data) async {
  //   var token = await UserInfo().getToken();
  //   var responseJson;
  //   try {
  //     final response = await http.put(
  //       Uri.parse(url),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(data),
  //     );
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  Future<dynamic> put(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: data,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer  $token"});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
