import 'dart:typed_data';

import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';


class LoginAdapter {
  static User decodeProto(Uint8List encodedUser) {
    try {
      return User.fromBuffer(encodedUser);
    } catch (e) {
      throw Exception('Eurro ao decodificar o proto');
    }
  }

  static Uint8List encodeProto(User user) {
    return user.writeToBuffer();
  }
}