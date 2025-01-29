import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class BloodBankService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/doadores';

  Future<void> uploadDonors(String filePath) async {
    final uri = Uri.parse('$baseUrl/upload');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Erro no upload: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> getStats() async {
    final responses = await Future.wait([
      _getStats('estatisticas/estados'),
      _getStats('estatisticas/imc-por-idade'),
      _getStats('estatisticas/obesidade-por-sexo'),
      _getStats('estatisticas/media-idade-tipo-sanguineo'),
      _getStats('estatisticas/doadores-compativeis'),
    ]);

    final allEmpty = responses.every(
        (data) => data is Map && data.isEmpty || data is List && data.isEmpty);

    if (allEmpty)
      throw Exception('Nenhum dado disponível para gerar estatísticas');

    return {
      'estados': responses[0],
      'imc_por_idade': responses[1],
      'obesidade': responses[2],
      'media_idade_tipo_sanguineo': responses[3],
      'doadores_por_receptor': responses[4],
    };
  }

  Future<dynamic> _getStats(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load $endpoint');
  }

  Future<void> uploadLocalDonors() async {
    try {
      // Carrega o arquivo local
      final jsonData = await rootBundle.loadString('data/data.json');

      // Valida o formato JSON
      final jsonList = json.decode(jsonData) as List;
      if (jsonList.isEmpty) throw Exception('Arquivo JSON vazio');

      // Envia diretamente no corpo da requisição
      final uri = Uri.parse('$baseUrl/upload');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode != 200) {
        throw Exception('Erro no upload: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao carregar arquivo local: $e');
    }
  }
}
