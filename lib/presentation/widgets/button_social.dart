import 'package:flutter/material.dart';

class ButtonSocial extends StatelessWidget {
  final String label;
  final VoidCallback ontap;
  final String logo;
  const ButtonSocial(
      {super.key,
      required this.label,
      required this.ontap,
      required this.logo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffC8D0D9)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)),
          width: 327,
          height: 44,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(logo),
            SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            )
          ]),
        ));
  }
}
