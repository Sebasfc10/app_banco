import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final bool hasIcon;
  final TextEditingController controller;
  final String hintText;
  final String prefixIcon;
  final bool obscureText;
  final Function(String) onChanged;
  const TextFieldCustom(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.prefixIcon,
      this.obscureText = false,
      required this.hasIcon,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xffC8D0D9)), // Color del borde
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xffC8D0D9)),
          prefixIcon: hasIcon == true
              ? ImageIcon(
                  AssetImage(prefixIcon),
                  color: Color(0xffC8D0D9),
                )
              : null,

          border: InputBorder.none, // No mostrar el borde por defecto
          contentPadding: EdgeInsets.symmetric(
              horizontal: 16, vertical: 12), // Espaciado interno
        ),
      ),
    );
  }
}
