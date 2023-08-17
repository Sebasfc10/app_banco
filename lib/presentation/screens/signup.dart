import 'package:app_banca/config/config.dart';
import 'package:app_banca/presentation/screens/login.dart';
import 'package:app_banca/presentation/widgets/button_custom.dart';
import 'package:app_banca/presentation/widgets/form_two_item.dart';
import 'package:flutter/material.dart';
import 'package:story/story_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passController.text);
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
                  Text(
                    'Regístrate',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Solo te tomará unos minutos.',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xff91A1B2),
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  FormTwoItems(
                    titleColor: 0xff91A1B2,
                    title: 'Nombre completo',
                    hasIcon: true,
                    controller: nameController,
                    hintText: 'Escribe tu nombre',
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
                    title: 'Identificación',
                    hasIcon: false,
                    controller: idController,
                    hintText: 'Escribe tu número de identificación',
                    obscureText: false,
                    prefixIcon: '',
                    onChanged: (text) {},
                  ),
                  FormTwoItems(
                    titleColor: 0xff91A1B2,
                    title: 'Email',
                    hasIcon: true,
                    controller: emailController,
                    hintText: 'Uname@mail.com',
                    obscureText: false,
                    prefixIcon: 'assets/logo/person.png',
                    onChanged: (text) {},
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
                            'Acepto los Términos y Condiciones y la Política de privacidad de Banca créditos ',
                            style: TextStyle(
                                height: 1.0,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xff0C1022)),
                          ),
                        )
                      ],
                    ),
                  ),
                  ButtonCustom(
                      colorBackground: 0xff5428F1,
                      colorText: 0xffFFFFFF,
                      label: 'Continuar',
                      ontap: () {
                        _saveData();
                        Navigator.pushNamed(context, RouteList.login);
                      }),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: MediaQuery.of(context).size.width * 0.15,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '¿Ya tienes una cuenta?',
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
                                return const Login();
                              },
                            ),
                          ),
                          child: Text(
                            'Inicia sesión',
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
