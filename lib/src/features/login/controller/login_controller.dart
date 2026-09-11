import 'package:movies_flutter_rvtc/src/features/login/data/repositories/login_repository.dart';
import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';
import 'package:signals/signals_flutter.dart';

class LoginController {
  final LoginRepository loginRepository;

  LoginController(this.loginRepository);

  final _isLoading = signal<bool>(false);
  final _error = signal<String?>(null);
  final user = signal<User?>(null);

  bool get isLoading => _isLoading.value;
  String? get error => _error.value;

  void initUser(User authenticatedUser) {
    user.value = authenticatedUser;
  }

  Future<bool> login(String username, String password) async {
    try {
      _isLoading.value = true;
      _error.value = null;

      final userCredentials = User()
        ..id = 0
        ..username = username
        ..password = password;

      final userResponse = await loginRepository.login(userCredentials);

      initUser(userResponse);
      return true;
    } catch (e) {
      _error.value = 'Falha no login: $e';
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  void logout() {
    batch(() {
      user.value = null;
      _error.value = null;
    });
  }
}