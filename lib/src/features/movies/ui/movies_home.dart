import 'package:flutter/material.dart';
import 'package:movies_flutter_rvtc/src/core/di/injection.dart';
import 'package:movies_flutter_rvtc/src/features/movies/controller/movies_controller.dart';
import 'package:movies_flutter_rvtc/src/features/movies/ui/movies_list.dart';
import 'package:movies_flutter_rvtc/src/features/movies/ui/movies_rented.dart';
import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';

class HomePage extends StatelessWidget {
  // receber usuario como arg
  final User user;
  


  const HomePage(this.user, {
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final MoviesController moviesController = getIt();
    moviesController.initUser(user);

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 91, 24, 172),
          title: const Text('User', style: TextStyle(color: Colors.white),),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_4x4,  color: Colors.white,), child: Text("Available movies", style: TextStyle(color: Colors.white ))),
              Tab(icon: Icon(Icons.list,  color: Colors.white,), child: Text("Movies rental", style: TextStyle(color: Colors.white )))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
           MoviesList(controller: moviesController,),
           MoviesRented(controller: moviesController,),
            //Forms2Page(),
          ],
        ),
      ),
    );
  }
}
