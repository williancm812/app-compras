import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WebServiceController {
  WebServiceController();

//  String url = "http://192.168.0.35:8090";
  String url = "https://api.sheety.co/7b99dbd42f05b20fa82f34ba950c7daf/appCompras";

  Future<Map<String, dynamic>> executeGetDb(
      {@required String query, String body = "", Duration duration = const Duration(seconds: 10)}) async {
    try {
      String returnValue;
      String currentUrl = url + query;
      print(currentUrl);
      await Future.delayed(Duration(milliseconds: 100));
      await http
          .get(
            currentUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          )
          .timeout(duration)
          .then(
            (http.Response response) {
              returnValue = utf8.decode(response.bodyBytes);
            },
          );
      print(returnValue);
      return jsonDecode(returnValue);
    } on TimeoutException catch (e) {
      return {'connection': e.toString()};
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> executePostDb({
    @required String query,
    Map<String, dynamic> body,
    Duration duration = const Duration(seconds: 10),
  }) async {
    try {
      String returnValue;
      String currentUrl = url + query;
      print(currentUrl);
      await Future.delayed(Duration(milliseconds: 100));
      await http
          .post(
            currentUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
            body: jsonEncode(body ?? {}),
          )
          .timeout(duration)
          .then(
        (http.Response response) {
          returnValue = utf8.decode(response.bodyBytes);
        },
      );
      print(returnValue);
      return jsonDecode(returnValue);
    } on TimeoutException catch (e) {
      return {'connection': e.toString()};
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> executePutDb({
    @required String query,
    @required Map<String, dynamic> body,
    Duration duration = const Duration(seconds: 10),
  }) async {
    try {
      String returnValue;
      String currentUrl = url + query;
      print(currentUrl);
      await Future.delayed(Duration(milliseconds: 100));
      await http
          .put(
            currentUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
            body: jsonEncode(body),
          )
          .timeout(duration)
          .then(
        (http.Response response) {

          if (response.bodyBytes.isNotEmpty) returnValue = utf8.decode(response.bodyBytes);
        },
      );

      if (returnValue == null) {
        return {'response': 200};
      }
      return jsonDecode(returnValue);
    } on TimeoutException catch (e) {
      print(e.toString());
      return {'connection': e.toString()};
    } catch (e) {
      print(e.toString());
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> executeDeleteDb(
      {@required String query, String body = "", Duration duration = const Duration(seconds: 10)}) async {
    try {
      String returnValue;
      String currentUrl = url + query;
      print(currentUrl);
      await Future.delayed(Duration(milliseconds: 100));
      await http
          .delete(
            currentUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          )
          .timeout(duration)
          .then(
            (http.Response response) {

              if (response.bodyBytes.isNotEmpty) returnValue = utf8.decode(response.bodyBytes);
            },
          );

      if (returnValue == null) {
        return {'response': 200};
      }
      return jsonDecode(returnValue);
    } on TimeoutException catch (e) {
      print(e.toString());
      return {'connection': e.toString()};
    } catch (e) {
      print(e.toString());
      return {'error': e.toString()};
    }
  }
}
