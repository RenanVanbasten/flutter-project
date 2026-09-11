import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_flutter_rvtc/src/core/di/injection.dart';
import 'package:movies_flutter_rvtc/src/core/routes/router.dart';

void main() async {
  await dotenv.load();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
   Widget build(BuildContext context) {
   return MaterialApp.router(
      routerConfig: router,
      title: "Meu router",
    );
  }
}