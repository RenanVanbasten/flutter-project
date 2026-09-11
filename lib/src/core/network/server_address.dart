import 'package:flutter_dotenv/flutter_dotenv.dart';

final address = dotenv.get("ADDRESS");
final port = dotenv.getInt("PORT");
final userToken = dotenv.get("TOKEN");

final postLogin = "$address:$port/login";



final getAvailableMovies = "$address:$port/available-movies";
final postRentalMovie = "$address:$port/rental-movie";
final postMoviesRentalByUser = "$address:$port/movies-rental-by-user";
final postWatchMovie = "$address:$port/watch-movie";