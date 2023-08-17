import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final int colorBackground;
  final int colorText;
  final String label;
  final VoidCallback ontap;
  const ButtonCustom(
      {super.key,
      required this.colorBackground,
      required this.colorText,
      required this.label,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Color(colorBackground),
            borderRadius: BorderRadius.circular(10)),
        height: 50,
        width: 358,
        child: Center(
            child: Text(
          label,
          style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(colorText),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
