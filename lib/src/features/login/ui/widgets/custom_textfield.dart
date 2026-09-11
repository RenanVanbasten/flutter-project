import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String label;
  final TextEditingController controller;

  const new({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(controller: controller,
           decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white)
             ), 
             label: Text(label,style: TextStyle(color: Colors.white, // Usa uma cor pronta do Material
  ))
            ),
          );
  }
}