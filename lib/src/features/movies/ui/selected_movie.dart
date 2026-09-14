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
      backgroundColor: const Color.fromARGB(255, 50, 5, 58),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 137, 18, 158),
        leading: IconButton(
          onPressed: () => {
            context.go('/home')
          }, 
          icon: Icon(Icons.arrow_back, color: Colors.white,)
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            decoration: BoxDecoration(
            color:  const Color.fromARGB(255, 50, 5, 58),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.white, 
              width: 1.0,      
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                   Expanded(
                     child: Image.memory(
                          Uint8List.fromList(movie.cover),
                          errorBuilder: (_, _, _) => const Icon(Icons.broken_image, size: 50),
                        ),
                   ),
                    Text("R\$ ${movie.value.toStringAsFixed(2)}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                     Text(movie.title, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                     Text(movie.sinopse, style: TextStyle(color: Colors.white),),
                     Spacer(),
                     Row(
                      spacing: 20,
                       children: [
                         Column(
                           children: [
                             Text("Year", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                             Text(movie.year, style: TextStyle(color: Colors.white),),
                           ],
                         ),
                         Column(
                            children: [
                              Text("Director", style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),),
                              Text(movie.director, style: TextStyle(color: Colors.white),),
                            ],
                          ),
                       ],
                     ),
                  
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 20,
                      children: [
                        ElevatedButton(onPressed: () => { context.pop()},  style: ElevatedButton.styleFrom(backgroundColor:  const Color.fromARGB(255, 50, 5, 58), 
                         side: const BorderSide(color: Colors.white,
                                                width: 1.0,) ),
                        child: Text("Cancel"),),


                        ElevatedButton(onPressed: ()  {
                         
                          return context.pop();
                        }, 
                        child: Text("Watch"))
                      ],
                     )
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}