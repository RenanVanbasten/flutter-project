import 'package:movies_flutter_rvtc/src/features/login/data/adapters/login_adapters.dart';
import 'package:movies_flutter_rvtc/src/features/login/data/datasources/login_datasource.dart';
import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';


class LoginRepository {
  final LoginDatasource loginDatasource;

  LoginRepository(this.loginDatasource);

  Future<User> login(User user) async {
    try {
      final userBytes = LoginAdapter.encodeProto(user);
      final responseBytes = await loginDatasource.login(userBytes);
      return LoginAdapter.decodeProto(responseBytes);
    } catch (e) {
      throw Exception('Erro login: $e');
    }
  }
}