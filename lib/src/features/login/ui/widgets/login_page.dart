import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_flutter_rvtc/src/core/di/injection.dart';
import 'package:movies_flutter_rvtc/src/features/login/controller/login_controller.dart';
import 'package:movies_flutter_rvtc/src/features/login/ui/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key}); 

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController(text: '');
  final _password = TextEditingController(text: '');
  final _loginController = getIt<LoginController>();


  Future<void> _handleLogin() async {
    final username = _username.text;
    final password = _password.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    final success = await _loginController.login(username, password);

    if (!mounted) return;

    if (success) {
      context.go('/home', extra: _loginController.user.value);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_loginController.error ?? 'Erro desconhecido')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.8,
            child: const Image(
              image: AssetImage("assets/image.png"),
              repeat: ImageRepeat.repeat,
              width: double.maxFinite,
              height: double.maxFinite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                height: 300,
                width: 310,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      CustomTextField(label: "Username", controller: _username),
                      CustomTextField(label: "Password", controller: _password),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Esqueceu a senha?",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {_handleLogin(); }
                        ,style: ElevatedButton.styleFrom(
                            fixedSize: const Size(130, 25),),
                        child: const Text("Entrar"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
