import 'dart:convert';
import 'package:http/http.dart' as http;

class BloodBankService {
  static const String baseUrl = 'http://10.0.2.2:8080/api';

  Future<void> uploadDonors(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    
    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Erro no upload');
    }
  }

  Future<Map<String, dynamic>> getStats() async {
    final response = await http.get(Uri.parse('$baseUrl/stats'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Falha ao carregar estatísticas');
  }
}