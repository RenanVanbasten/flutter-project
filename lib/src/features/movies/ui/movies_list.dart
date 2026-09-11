import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_flutter_rvtc/src/features/movies/controller/movies_controller.dart';
import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';
import 'package:signals/signals_flutter.dart';

class MoviesList extends SignalWidget {
  const MoviesList({
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
    final movies = controller.availableMovies.value;
    final isLoading = controller.isLoading;
    final error = controller.error;

    if (isLoading && movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
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

    if (movies.isEmpty) {
      return const Center(child: Text('Nenhum filme disponível no momento.'));
    }

    // Adicionado Container com cor de fundo roxa
    return Container(
      color: const Color.fromARGB(255, 44, 1, 52), // Você também pode usar Colors.purple.shade900 para um roxo mais escuro
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (_, int index) {
          final movie = movies[index];
          return InkWell(
            onTap: () {
              context.go('/info', extra: movie);
            },
            onLongPress: () => onLongPress?.call(movie),
            child: GridTile(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: movie.cover.isNotEmpty
                        ? Image.memory(
                            Uint8List.fromList(movie.cover),
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                const Icon(Icons.broken_image, size: 50),
                          )
                        : const Icon(Icons.movie, size: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      movie.title,
                      // Alterado para branco para dar contraste com o fundo roxo
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, 
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
