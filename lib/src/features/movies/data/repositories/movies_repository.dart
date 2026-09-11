import 'package:movies_flutter_rvtc/src/features/login/data/adapters/login_adapters.dart';
import 'package:movies_flutter_rvtc/src/features/movies/data/adapters/movies_adapters.dart';
import 'package:movies_flutter_rvtc/src/features/movies/data/datasources/movies_datasource.dart';
import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';


class MoviesRepository {
  final MoviesDatasource moviesDatasource;

  MoviesRepository(this.moviesDatasource);

  Future<Movies> availableMovies() async {
    try {
      final responseBytes = await moviesDatasource.availableMovies();
      return MoviesAdapter.decodeMoviesProto(responseBytes);
    } catch (e) {
      throw Exception('Erro ao buscar os filmes disponíveis: $e');
    }
  }

  Future<void> rentMovie(Rental rental) async {
    try {
      final rentalBytes = MoviesAdapter.encodeRentalProto(rental);
      await moviesDatasource.rentMovie(rentalBytes);
    } catch (e) {
      throw Exception('Erro ao alugar filme: $e');
    }
  }

  Future<Movies> rentedMovies(User user) async {
    try {
      final userBytes = LoginAdapter.encodeProto(user);
      final responseBytes = await moviesDatasource.rentedMovies(userBytes);
      return MoviesAdapter.decodeMoviesProto(responseBytes);
    } catch (e) {
      throw Exception('Erro ao buscar filmes alugados: $e');
    }
  }

  Future<void> watchMovie(Rental rental) async {
    try {
      final rentalBytes = MoviesAdapter.encodeRentalProto(rental);
      await moviesDatasource.watchMovie(rentalBytes);
    } catch (e) {
      throw Exception('Erro ao assistir/devolver filme: $e');
    }
  }
}