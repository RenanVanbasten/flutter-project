import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_flutter_rvtc/src/shared/proto/user_movies.pb.dart';

class SelectedMovie extends StatelessWidget {
  final Movie movie;
  const new({super.key, required this.movie});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 137, 18, 158),
        leading: IconButton(
          onPressed: () => {
            context.go('/home')
          }, 
          icon: Icon(Icons.arrow_back, color: Colors.white,)
        ),
      ),
      body: 

        Container(
          decoration: BoxDecoration(
            color:  const Color.fromARGB(255, 50, 5, 58),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                   Image.memory(
                    width: 400,
                        Uint8List.fromList(movie.cover),
                        errorBuilder: (_, _, _) => const Icon(Icons.broken_image, size: 50),
                      ),
                    Text("R\$ ${movie.value.toStringAsFixed(2)}", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                   Text(movie.title, style: TextStyle(color: Colors.white),),
                   Text(movie.sinopse, style: TextStyle(color: Colors.white),),
                
                   Row(
                    spacing: 40,
                     children: [
                       Column(
                         children: [
                           Text("Year", style: TextStyle(color: Colors.white),),
                           Text(movie.year, style: TextStyle(color: Colors.white),),
                         ],
                       ),
                       Column(
                          children: [
                            Text("Director", style: TextStyle(color: Colors.white),),
                            Text(movie.director, style: TextStyle(color: Colors.white),),
                          ],
                        ),
                     ],
                   ),
                
                   
                   
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}