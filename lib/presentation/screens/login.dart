import 'dart:math';

import 'package:app_banca/config/config.dart';
import 'package:app_banca/presentation/screens/check_screen.dart';
import 'package:app_banca/presentation/screens/signup.dart';
import 'package:app_banca/presentation/widgets/button_custom.dart';
import 'package:app_banca/presentation/widgets/button_social.dart';
import 'package:app_banca/presentation/widgets/form_two_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/story_image.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  late String hasEmail;
  late String hasPassword;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';
    setState(() {
      hasEmail = email;
      hasPassword = password;
      /* nameController.text = email;
      passController.text = password; */
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: 85,
            right: 85,
            child: StoryImage(
              key: ValueKey('assets/logo/logo.png'),
              imageProvider: AssetImage('assets/logo/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.18,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'Inicia sesión o continua,',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' solo te tomará',
                          style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                        )
                      ],
                    ),
                  ),
                  Text(
                    'unos minutos.',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  FormTwoItems(
                    titleColor: 0xff91A1B2,
                    title: 'Email or Usuario',
                    hasIcon: true,
                    controller: emailController,
                    hintText: 'Uname@mail.com',
                    obscureText: false,
                    prefixIcon: 'assets/logo/person.png',
                    onChanged: (text) {
                      setState(() {
                        isChecked = text.isNotEmpty;
                      });
                    },
                  ),
                  FormTwoItems(
                    titleColor: 0xff91A1B2,
                    title: 'Contraseña',
                    hasIcon: true,
                    controller: passController,
                    hintText: 'Password',
                    obscureText: false,
                    prefixIcon: 'assets/logo/lock.png',
                    onChanged: (text) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Checkbox(
                            checkColor: Colors.white,
                            activeColor: Color(0xff5428F1),
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            side: BorderSide(color: Colors.grey.shade400)),
                        Expanded(
                          child: Text(
                            'Recordarme',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xff0C1022)),
                          ),
                        ),
                        Text(
                          '¿Olvide mi contraseña?',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xff5428F1)),
                        )
                      ],
                    ),
                  ),
                  ButtonCustom(
                      colorBackground: 0xff5428F1,
                      colorText: 0xffFFFFFF,
                      label: 'Iniciar sesión',
                      ontap: () {
                        if (hasEmail == emailController.text &&
                            hasPassword == passController.text) {
                          print('Credenciales Correctas');
                          Navigator.pushReplacementNamed(
                              context, RouteList.check);
                        } else {
                          print('Credenciales falsas');
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'O',
                            style: TextStyle(
                                color: Colors.grey, fontFamily: 'Poppins'),
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonSocial(
                      label: 'Ingresa con Google',
                      ontap: () {},
                      logo: 'assets/logo/Logogoogle.png'),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonSocial(
                      label: 'Ingresa con Apple',
                      ontap: () {},
                      logo: 'assets/logo/Logoapple.png'),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: MediaQuery.of(context).size.width * 0.15,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '¿No tienes una cuenta?',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff808A93),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUp();
                              },
                            ),
                          ),
                          child: Text(
                            'Registrate',
                            style: TextStyle(
                                color: Color(0xff5428F1),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
