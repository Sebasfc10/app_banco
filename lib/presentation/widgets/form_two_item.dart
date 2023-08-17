import 'package:app_banca/presentation/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';

class FormTwoItems extends StatelessWidget {
  final int titleColor;
  final String title;
  final bool hasIcon;
  final TextEditingController controller;
  final String hintText;
  final String prefixIcon;
  final bool obscureText;
  final Function(String) onChanged;
  const FormTwoItems(
      {super.key,
      required this.title,
      required this.hasIcon,
      required this.controller,
      required this.hintText,
      required this.prefixIcon,
      required this.obscureText,
      required this.onChanged,
      required this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(titleColor),
                  fontFamily: 'Poppins',
                  fontSize: 14),
            ),
          ),
        ),
        TextFieldCustom(
          onChanged: onChanged,
          controller: controller,
          hintText: hintText,
          prefixIcon: prefixIcon,
          obscureText: obscureText,
          hasIcon: hasIcon,
        ),
      ],
    );
  }
}
