import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).colorScheme.secondary,
              blurRadius: 10,
              spreadRadius: 2),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.background,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: Colors.transparent), // Añade esta línea
          ),
          labelText: 'Enter your username',
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          hintText: hintText,
        ),
      ),
    );
  }
}
