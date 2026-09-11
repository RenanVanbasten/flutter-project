import 'dart:typed_data';

import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';

class MoviesAdapter{

 static Movies decodeMoviesProto(Uint8List encodedMovies) {
    try {
      return Movies.fromBuffer(encodedMovies);
    } catch (e) {
      throw Exception('Erro ao decodificar o Movies proto');
    }
  }

  static Uint8List encodeRentalProto(Rental rental) {
    return rental.writeToBuffer();
  }

  static Uint8List encodeUserProto(User user) {
    return user.writeToBuffer();
  }


}

