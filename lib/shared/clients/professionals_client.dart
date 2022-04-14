

import 'dart:convert';

import 'package:estetica_beleza/models/tables/professional.dart';
import 'package:estetica_beleza/shared/clients/response_request.dart';
import 'package:estetica_beleza/shared/exceptions/app_exception.dart';
import 'package:estetica_beleza/shared/utils/util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'commom_client.dart';

class ProfessionalsClient {
  Future<List<Professional>> consultarProfessionals(String? nomeServico) async {
    String? mensagemErro;
    String? token = "";
    String? servico = nomeServico;

     var data = {
      "nomeServico": servico
    };

    var resp = await CommomClient.postRequest(
      DotEnv.dotenv.env['BACKEND_URL_BASE']! + "/professionals/findAll",
      data,
      token!,
      timeout: Duration(seconds: 30),
    );

    if (resp.statusCode == 200) {
      var jsonToken = json.decode(utf8.decode(resp.bodyBytes));
      ResponseRequest rr = ResponseRequest.fromJson(jsonToken);
      if (rr.statusCode == 200) {
        return rr.data.map<Professional>((v) => Professional.fromJsonApi(v)).toList();
      }
      mensagemErro = rr.getMensagens();
    } else {
      CommomClient.tratarRetornoHTTP(resp.statusCode);
    }
    throw AppException(AppException.levelWarning,
        coalesceEmpty(mensagemErro!, 'Problemas ao consultar Banco de Dados'));
  }
}