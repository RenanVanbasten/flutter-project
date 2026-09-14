import 'package:go_router/go_router.dart';
import 'package:movies_flutter_rvtc/src/features/login/ui/widgets/login_page.dart';
import 'package:movies_flutter_rvtc/src/features/movies/ui/movies_home.dart';
import 'package:movies_flutter_rvtc/src/features/movies/ui/selected_movie.dart';
import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';



final router = GoRouter(

  initialLocation: "/loginpage",
  routes: [
  GoRoute(
      path: "/loginpage",
      builder: (context, state) => LoginPage(),),
      GoRoute(
      path: "/home",
      builder: (context, state) {
        final user = state.extra as User;
        return  HomePage(user);
      },),
      GoRoute(
      path: "/info",
      builder: (context, state) {
        Movie movie = state.extra as Movie;
        return SelectedMovie(movie: movie);
      }),
]);