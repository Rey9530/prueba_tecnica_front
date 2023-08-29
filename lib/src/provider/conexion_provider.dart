import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class CodeResponseHttp {
  CodeResponseHttp({
    required this.statusCode,
    required this.body,
  });

  dynamic body;
  int statusCode;

  factory CodeResponseHttp.fromJson(Map<String, dynamic> json) =>
      CodeResponseHttp(
        statusCode: json["statusCode"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "body": body,
      };
}

class ConexionesProvider extends ChangeNotifier {
  var errorConexion = CodeResponseHttp(
    body:
        ' { "status": 401, "message": "No se ha detectado conexión a internet", "info": {"data": null} }',
    statusCode: 401,
  );
  bool conected = true;
  ConexionesProvider() {
    verifyConection();
  }

  Map<String, String> requestHeaders = {'Accept': '*/*'};

  final String _baseUrl = API_URL;

  get_(String endpoint,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    final conected = await verifyConection();
    if (!conected) {
      return errorConexion;
    }
    requestHeaders = {
      ...requestHeaders,
      ...?headers,
    };

    final url = Uri.https(_baseUrl, endpoint, {...?queryParameters});
    http.Response response;
    try {
      response = await http
          .get(url, headers: requestHeaders)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return CodeResponseHttp(
        body:
            ' { "status": 401, "message": "Tiempo de espera alcanzado", "info": {"data": null} }',
        statusCode: 401,
      );
    } on SocketException {
      throw ('Sin internet  o falla de servidor ');
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }
    return response;
  }

  getSinheader(String endpoint,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    final conected = await verifyConection();
    if (!conected) {
      return errorConexion;
    }
    requestHeaders = {...requestHeaders, ...?headers};
    final url = Uri.https(_baseUrl, endpoint, {...?queryParameters});
    http.Response response;
    try {
      response = await http
          .get(url, headers: requestHeaders)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      throw ('Tiempo de espera alcanzado');
    } on SocketException {
      throw ('Sin internet  o falla de servidor ');
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }

    return response;
  }

  post_(String endpoint, dynamic body,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    final conected = await verifyConection();
    if (!conected) {
      return errorConexion;
    }
    final url = Uri.https(_baseUrl, endpoint);
    Map<String, String> headersRequest = {
      ...requestHeaders,
      ...?headers,
    };
    http.Response response;
    try {
      response = await http
          .post(url, body: body, headers: headersRequest)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      return CodeResponseHttp(
        body:
            ' { "status": 401, "message": "WaitTimeReached", "info": {"data": null} }',
        statusCode: 401,
      );

      // throw ('Tiempo de espera alcanzado');
    } on SocketException {
      String body =
          ' { "status": 401, "message": "ServerError", "info": {"data": null} }';
      return CodeResponseHttp(
        body: body,
        statusCode: 401,
      );
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }

    return response;
  }

  put_(String endpoint, dynamic body,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    final conected = await verifyConection();
    if (!conected) {
      return errorConexion;
    }
    final url = Uri.https(_baseUrl, endpoint, {...?queryParameters});
    requestHeaders = {
      ...requestHeaders,
      ...?headers,
    };
    http.Response response;

    try {
      response = await http
          .put(url, body: body, headers: requestHeaders)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      throw ('Tiempo de espera alcanzado');
    } on SocketException {
      throw ('Sin internet  o falla de servidor ');
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }
    return response;
  }

  delte_(String endpoint,
      [Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers]) async {
    final conected = await verifyConection();
    if (!conected) {
      return errorConexion;
    }
    final url = Uri.https(_baseUrl, endpoint, {...?queryParameters});
    requestHeaders = {
      ...requestHeaders,
      ...?headers,
    };
    http.Response response;

    try {
      response = await http
          .delete(url, headers: requestHeaders)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (_) {
      throw ('Tiempo de espera alcanzado');
    } on SocketException {
      throw ('Sin internet  o falla de servidor ');
    } on HttpException {
      throw ("No se encontro esa peticion");
    } on FormatException {
      throw ("Formato erroneo ");
    }
    return response;
  }

  customer_(Uri uri, {Map<String, String>? headers}) async {
    final conected = await verifyConection();
    if (!conected) {
      return "";
    }
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  verifyConection() async {
    return true;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   conected = true;
    //   // I am connected to a mobile network.
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   conected = true;
    //   // I am connected to a wifi network.
    // } else {
    //   conected = false;
    //   notifyListeners();
    // }
    // return conected;
  }
}
