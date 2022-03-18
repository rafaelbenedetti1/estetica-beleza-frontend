import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:estetica_beleza/shared/clients/response_request.dart';
import 'package:estetica_beleza/shared/exceptions/app_exception.dart';
import 'package:estetica_beleza/shared/utils/util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'package:http/http.dart' as http;

class CommomClient {
  static Future<http.Response> getRequest(String url, String token,
      {Duration timeout = const Duration(seconds: 10)}) async {
    Map<String, String> headers = new Map();
    if (token != null) {
      headers['Authorization'] = 'bearer $token';
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers).timeout(timeout);
    return response;
  }

  static Future<http.Response> postRequest(String url, String dropdown, Map data, String token,
      {Duration timeout = const Duration(seconds: 10)}) async {
    if (dropdown != url && dropdown.isNotEmpty) {
      var body;
      if (data != null) body = json.encode(data);
      var headers = {
        'Content-Type': 'application/json',
      };
      if (token != null) {
        headers['Authorization'] = "Bearer $token";
      }
      http.Response response = await http.post(Uri.parse(dropdown), body: body, headers: headers).timeout(timeout);
      return response;
    } else {
      var body;
      if (data != null) body = json.encode(data);
      var headers = {
        'Content-Type': 'application/json',
      };
      if (token != null) {
        headers['Authorization'] = "Bearer $token";
      }
      http.Response response = await http.post(Uri.parse(url), body: body, headers: headers).timeout(timeout);
      return response;
    }
  }

  static Future<http.Response> deleteRequest(String url, Map data, String token,
      {Duration timeout = const Duration(seconds: 10)}) async {
    var body;
    if (data != null) body = json.encode(data);
    var headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = "Bearer $token";
    }
    http.Response response = await http.delete(Uri.parse(url), body: body, headers: headers).timeout(timeout);
    return response;
  }

  static Future<http.Response> postForm(String url, Map data,
      {Duration timeout = const Duration(seconds: 10), Map? customHeader}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (ConnectivityResult.none == connectivityResult) {
      throw AppException(AppException.levelWarning, "É necessário conexão com a internet para continuar");
    }
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    // TODO: Validar se esse cast não vai dar erro
    if (customHeader != null) headers.addAll(customHeader as Map<String, String>);
    http.Response response = await http.post(Uri.parse(url), body: data, headers: headers).timeout(timeout);
    return response;
  }

  // Busca na os apps da central de aplicações para o menu
  Future buscarApps() async {
    String? mensagemErro;
    String? token = '';
    var resp = await CommomClient.getRequest(
      DotEnv.dotenv.env['REACT_APP_URL_LINK_API']!,
      token!,
      timeout: Duration(seconds: 30),
    );
    if (resp.statusCode == 200) {
      var jsonToken = json.decode(utf8.decode(resp.bodyBytes));
      ResponseRequest rr = ResponseRequest.fromJson(jsonToken);
      if (rr.statusCode == 200) {
        return rr.data;
      }
      mensagemErro = rr.getMensagens();
    } else {
      CommomClient.tratarRetornoHTTP(resp.statusCode);
    }
    throw AppException(
        AppException.levelWarning, coalesceEmpty(mensagemErro!, 'Problemas ao consultar Banco de Dados'));
  }

  static tratarRetornoHTTP(int statusCode) {
    switch (statusCode) {
      case 200:
      case 201:
        return null;
      case 500:
        throw AppException(AppException.levelWarning, "Erro no servidor ao processar a requisição.",
            codeError: "erro_500");
      case 404:
        throw AppException(AppException.levelWarning, "Serviço está fora do ar.", codeError: "erro_404");
      case 401:
        throw AppException(AppException.levelWarning, "O app não está mais logado, faça o login novamente.",
            codeError: "erro_401");
      default:
        throw AppException(AppException.levelWarning, "Erro $statusCode ao processar a requisição.");
    }
  }
}
