import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_rvtc/src/core/network/server_address.dart';

class LoginDatasource {
  
     final http.Client client;

     LoginDatasource(this.client);

   Future<Uint8List> login(Uint8List userBytes) async {
    try {
      final response = await client.post(
        Uri.parse(postLogin), 
        headers: {'Content-Type': 'application/x-protobuf'},
        body: userBytes,
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Erro login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Não foi possível conectar ao servidor: $e');
    }
  }
}

