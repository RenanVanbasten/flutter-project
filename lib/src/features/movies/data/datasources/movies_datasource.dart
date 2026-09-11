import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_rvtc/src/core/network/server_address.dart';

class MoviesDatasource {
  final http.Client client;
  MoviesDatasource(this.client);

  Future<Uint8List> availableMovies() async {
    try {
      final response = await client.get(
        Uri.parse(getAvailableMovies),
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Falha ao listar os filmes disponíveis: ${response.bodyBytes}');
      }
    } catch (e) {
      throw Exception('Servidor nao conectado: $e');
    }
  }

  Future<void> rentMovie(Uint8List rentalBytes) async {
    try {
      final response = await client.post(
        Uri.parse(postRentalMovie), 
        headers: {
          'Content-Type': 'application/x-protobuf',
          'X-Student-Token': userToken,
        },
        body: rentalBytes,
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao alugar filme: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Servidor não conectado: $e');
    }
  }

  Future<Uint8List> rentedMovies(Uint8List userBytes) async {
    try {
      final response = await client.post(
        Uri.parse(postMoviesRentalByUser), 
        headers: {
          'Content-Type': 'application/x-protobuf',
          'X-Student-Token': userToken,
        },
        body: userBytes,
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Falha ao listar filmes alugados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Servidor não conectado: $e');
    }
  }

  Future<void> watchMovie(Uint8List rentalBytes) async {
    try {
      final response = await client.post(
        Uri.parse(postWatchMovie),
        headers: {
          'Content-Type': 'application/x-protobuf',
          'X-Student-Token': userToken,
        },
        body: rentalBytes,
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao assistir/devolver filme: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Servidor não conectado: $e');
    }
  }
}