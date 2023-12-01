import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;

  const InputTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon = Icons.edit,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
