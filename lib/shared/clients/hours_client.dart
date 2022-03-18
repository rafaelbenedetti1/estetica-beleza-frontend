import 'dart:convert';

import 'package:estetica_beleza/models/tables/hours.dart';
import 'package:estetica_beleza/shared/clients/commom_client.dart';
import 'package:estetica_beleza/shared/clients/response_request.dart';
import 'package:estetica_beleza/shared/utils/util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import '../exceptions/app_exception.dart';

class HoursClient {
  Future<List<Hour>> consultarHours(int profissionalId) async {
    String? mensagemErro;
    String? token = ;
    String? groupName;
    int? profissional = profissionalId;

    var resp = await CommomClient.getRequest(
      DotEnv.dotenv.env['BACKEND_URL_BASE']! + "/hours/{profissional}",
      token!,
      timeout: Duration(seconds: 30),
    );

    if (resp.statusCode == 200) {
      var jsonToken = json.decode(utf8.decode(resp.bodyBytes));
      ResponseRequest rr = ResponseRequest.fromJson(jsonToken);
      if (rr.statusCode == 200) {
        return rr.data.map<Hour>((v) => Hour.fromJsonApi(v)).toList();
      }
      mensagemErro = rr.getMensagens();
    } else {
      CommomClient.tratarRetornoHTTP(resp.statusCode);
    }
    throw AppException(AppException.levelWarning,
        coalesceEmpty(mensagemErro!, 'Problemas ao consultar Banco de Dados'));
  }
}
