import 'package:go_router/go_router.dart';
import 'package:movies_flutter_rvtc/src/features/login/ui/widgets/login_page.dart';
import 'package:movies_flutter_rvtc/src/features/movies/ui/movies_home.dart';



final router = GoRouter(

  initialLocation: "/loginpage",
  routes: [
  GoRoute(
      path: "/loginpage",
      builder: (context, state) => LoginPage(),),
      GoRoute(
      path: "/home",
      builder: (context, state) => HomePage(),)
]);