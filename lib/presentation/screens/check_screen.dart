import 'package:app_banca/config/config.dart';
import 'package:app_banca/presentation/screens/signup.dart';
import 'package:app_banca/presentation/widgets/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:story/story_image.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff997FF8),
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              left: 25,
              right: 25,
              child: Image.asset('assets/logo/logocheck.png')),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: 25,
            right: 25,
            child: Column(
              children: [
                Text(
                  'Registro exitoso',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                Text(
                  'Hemos guardado tus credenciales de forma exitosa, Presiona continuar para seguir adelante.',
                  style: TextStyle(
                      color: Color(0xff91A1B2),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ButtonCustom(
                      colorBackground: 0xff5428F1,
                      colorText: 0xffFFFFFF,
                      label: 'Continuar',
                      ontap: () {
                        Navigator.pushReplacementNamed(
                            context, RouteList.root0);
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
