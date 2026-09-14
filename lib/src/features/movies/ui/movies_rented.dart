import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:movies_flutter_rvtc/src/features/movies/controller/movies_controller.dart';
import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';
import 'package:signals/signals_flutter.dart';

class MoviesRented extends SignalWidget {
  const MoviesRented({
    super.key,
    required this.controller,
    this.onTap,
    this.onLongPress,
  });

  final MoviesController controller;
  final void Function(Movie movie)? onTap;
  final void Function(Movie movie)? onLongPress;

  @override
  Widget build(BuildContext context) {
    final movies = controller.rentalMovies.value;
    final error = controller.error;
    if (movies.isEmpty) {
      return const Center(
      child: Text('Nenhum filme alugado ainda.',
      style: TextStyle(color: Colors.white),),);
    }

    if (error != null && movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => controller.getAvailableMovies(),
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      );
    }


     return Container(
      color: const Color.fromARGB(255, 44, 1, 52),
      child: GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 250,
      childAspectRatio: 0.75,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
),
  itemBuilder: (_, int index) {
    final movie = movies[index];
    return InkWell(onTap: () => onTap?.call(movie),
    onLongPress: () => onLongPress?.call(movie),
    child: GridTile(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 50, 5, 58),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.white, width: 1.0),
              ),child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                    child: movie.cover.isNotEmpty
                    ? Image.memory(
                      Uint8List.fromList(movie.cover),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, _, _) => const Icon(Icons.broken_image, size: 50, color: Colors.white),
                      ): const Icon(Icons.movie, size: 50, color: Colors.white),
                    ),),
                    Padding( padding: const EdgeInsets.all(8.0),
                    child: Text( movie.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, ),
                    ),
                   ],
                  ),
                ),
              ),
            ),
           );
         }
     )
    );
  }
}