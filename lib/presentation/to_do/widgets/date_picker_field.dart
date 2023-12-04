import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onPressed;
  final IconData icon;

  const DatePickerField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onPressed,
    this.icon = Icons.edit,
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
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: onPressed,
        child: TextField(
          enabled: false,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
