import 'package:movies_flutter_rvtc/src/features/movies/data/repositories/movies_repository.dart';
import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';
import 'package:signals/signals_flutter.dart';


class MoviesController {
  final MoviesRepository moviesRepository;

  MoviesController(this.moviesRepository) {
    getAvailableMovies();
  }

  final _isLoading = signal<bool>(false);
  final _error = signal<String?>(null);
  final availableMovies = signal<List<Movie>>([]);
  final rentalMovies = signal<List<Movie>>([]);
  final user = signal<User?>(null);
  bool get isLoading => _isLoading.value;
  String? get error => _error.value;


    void initUser(User authenticatedUser) {
    user.value = authenticatedUser;
  }

  Future<void> getAvailableMovies() async {
    try {
      _isLoading.value = true;
      _error.value = null;

      final baseMovies = await moviesRepository.availableMovies();
      availableMovies.value = baseMovies.movies;
    } catch (e) {
      _error.value = 'Erro ao carregar os filmes: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getRentalMovie() async {
    final loggedUser = user.value;

    if (loggedUser == null) {
      _error.value = 'Usuário não loggado';
      return;
    }

    try {
      _isLoading.value = true;
      _error.value = null;

      final userFilter = User()
        ..id = loggedUser.id
        ..username = ''
        ..password = '';

      final baseMovies = await moviesRepository.rentedMovies(userFilter);
      rentalMovies.value = baseMovies.movies;
    } catch (e) {
      _error.value = 'Erro ao carregar filmes renteds: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> rentalMovie(int movieId) async {
    final loggedUser = user.value;

    if (loggedUser == null) {
      _error.value = 'Usuário não loggado';
      return false;
    }

    try {
      _isLoading.value = true;
      _error.value = null;

      final rental = Rental()
        ..userId = loggedUser.id
        ..movieId = movieId;

      await moviesRepository.rentMovie(rental);
      await getAvailableMovies();
      return true;
    } catch (e) {
      _error.value = 'Erro ao carregar filmes renteds: $e';
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> watchMovie(Movie movie) async {
    final loggedUser = user.value;

    if (loggedUser == null) {
      _error.value = 'Usuário não loggado';
      return false;
    }

    try {
      _isLoading.value = true;
      _error.value = null;

      final rental = Rental()
        ..userId = loggedUser.id
        ..movieId = movie.id;

      await moviesRepository.watchMovie(rental);
      await getRentalMovie();
      return true;
    } catch (e) {
      _error.value = 'Erro ao devolver/assistir o filme: $e';
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  void clearMovieData() {
    batch(() {
      availableMovies.value = [];
      rentalMovies.value = [];
      _error.value = null;
    });
  }
}