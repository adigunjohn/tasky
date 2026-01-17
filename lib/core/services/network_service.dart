import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tasky/utils/api_exception.dart';
import 'package:tasky/utils/constants.dart';
import 'package:tasky/utils/exception_handler.dart';

class NetworkService {

  void logInfo(String info){
    log('${AppConstants.networkServiceLog}$info');
  }

  final http.Client _client = http.Client();
  static const Duration _timeout = Duration(seconds: 30);


  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final uri = Uri.parse(endpoint);
    try {
      logInfo('Calling get request');
      final response = await _client.get(uri, headers: headers).timeout(_timeout);
      final statusCode = response.statusCode;
      logInfo('statusCode: $statusCode | ${ExceptionHandler.checkStatusCode(statusCode)}');

      if (statusCode >= 200 && statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        logInfo('responseBody: $responseBody');
        return responseBody;
      } else {
        logInfo('Get request failed');
        throw ApiException(ExceptionHandler.checkStatusCode(statusCode), statusCode: statusCode);
      }

    } on ApiException catch(e) {
      logInfo('ApiException: ${e.message}');
      rethrow;
    }  on SocketException catch(e){
      logInfo('No internet connection: $e');
      throw ApiException('No internet connection, please try again');
    } on http.ClientException catch(e){
      logInfo('HTTP Client error occurred: $e');
      throw ApiException('Network error occurred, please try again');
    }on TimeoutException catch(e){
      logInfo('Request timeout: $e');
      throw ApiException('Request timeout, please try again');
    } catch (e){
      logInfo('Unknown error occurred: $e');
      throw ApiException('Unknown error occurred, please try again');
    }
  }



  Future<dynamic> post(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    final uri = Uri.parse(endpoint);
    try {
      logInfo('Calling post request');
      final response = await _client.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(_timeout);

      final statusCode = response.statusCode;
      logInfo('statusCode: $statusCode | ${ExceptionHandler.checkStatusCode(statusCode)}');

      if (statusCode >= 200 && statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        logInfo('responseBody: $responseBody');
        return responseBody;
      } else {
        logInfo('Post request failed');
        throw ApiException(ExceptionHandler.checkStatusCode(statusCode), statusCode: statusCode);
      }

    } on ApiException catch(e) {
      logInfo('ApiException: ${e.message}');
      rethrow;
    } on SocketException catch(e){
      logInfo('No internet connection: $e');
      throw ApiException('No internet connection, please try again');
    } on http.ClientException catch(e){
      logInfo('HTTP Client error occurred: $e');
      throw ApiException('Network error occurred, please try again');
    }on TimeoutException catch(e){
      logInfo('Request timeout: $e');
      throw ApiException('Request timeout, please try again');
    } catch (e){
      logInfo('Unknown error occurred: $e');
      throw ApiException('Unknown error occurred, please try again');
    }
  }



  Future<dynamic> patch(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    final uri = Uri.parse(endpoint);
    try {
      logInfo('Calling patch request');
      final response = await _client.patch(
        uri,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(_timeout);

      final statusCode = response.statusCode;
      logInfo('statusCode: $statusCode | ${ExceptionHandler.checkStatusCode(statusCode)}');

      if (statusCode >= 200 && statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        logInfo('responseBody: $responseBody');
        return responseBody;
      } else {
        logInfo('Patch request failed');
        throw ApiException(ExceptionHandler.checkStatusCode(statusCode), statusCode: statusCode);
      }

    } on ApiException catch(e) {
      logInfo('ApiException: ${e.message}');
      rethrow;
    }  on SocketException catch(e){
      logInfo('No internet connection: $e');
      throw ApiException('No internet connection, please try again');
    } on http.ClientException catch(e){
      logInfo('HTTP Client error occurred: $e');
      throw ApiException('Network error occurred, please try again');
    }on TimeoutException catch(e){
      logInfo('Request timeout: $e');
      throw ApiException('Request timeout, please try again');
    } catch (e){
      logInfo('Unknown error occurred: $e');
      throw ApiException('Unknown error occurred, please try again');
    }
  }



  Future<dynamic> delete(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    final uri = Uri.parse(endpoint);
    try {
      logInfo('Calling delete request');
      final response = await _client.delete(
        uri,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(_timeout);

      final statusCode = response.statusCode;
      logInfo('statusCode: $statusCode | ${ExceptionHandler.checkStatusCode(statusCode)}');

      if (statusCode >= 200 && statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        logInfo('responseBody: $responseBody');
        return responseBody;
      } else {
        logInfo('Delete request failed');
        throw ApiException(ExceptionHandler.checkStatusCode(statusCode), statusCode: statusCode);
      }

    } on ApiException catch(e) {
      logInfo('ApiException: ${e.message}');
      rethrow;
    }  on SocketException catch(e){
      logInfo('No internet connection: $e');
      throw ApiException('No internet connection, please try again');
    }  on http.ClientException catch(e){
      logInfo('HTTP Client error occurred: $e');
      throw ApiException('Network error occurred, please try again');
    }on TimeoutException catch(e){
      logInfo('Request timeout: $e');
      throw ApiException('Request timeout, please try again');
    } catch (e){
      logInfo('Unknown error occurred: $e');
      throw ApiException('Unknown error occurred, please try again');
    }
  }



}