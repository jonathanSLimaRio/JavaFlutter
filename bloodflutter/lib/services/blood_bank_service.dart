import 'dart:convert';
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
}