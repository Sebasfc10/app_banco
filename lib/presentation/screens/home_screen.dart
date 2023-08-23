import 'package:app_banca/cubit/loan_calculator_cubit.dart';
import 'package:app_banca/presentation/widgets/button_custom.dart';
import 'package:app_banca/presentation/widgets/form_two_item.dart';
import 'package:app_banca/presentation/widgets/show_modal_bottom.dart';
import 'package:app_banca/presentation/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController creditController = TextEditingController();
  final TextEditingController loanController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  String enteredNumber = '';
  bool validationMessage = true;

  double originalPrice = 0;
  double discountPercentage = 0.1;
  double discountedPrice = 0;
  String welcomeName = '';

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    setState(() {
      welcomeName = name;
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'es_CO', symbol: '', decimalDigits: 0);
    final cubit = context.read<LoanCalculatorCubit>();
    loanController.text = cubit.state.montoMaximo.toStringAsFixed(2);
    /*   String newCredit = '\$${currencyFormatter.format(creditController)}'; */
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hola, $welcomeName",
                //textAlign: TextAlign.start,
                style: const TextStyle(
                    fontFamily: 'Poppins', fontSize: 22, color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const ImageIcon(
                    AssetImage('assets/logo/alerticon.png'),
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              )
            ]),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<LoanCalculatorCubit, LoanCalculatorState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Simulador de crédito',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xff5428F1),
                              fontFamily: 'Poppins',
                              fontSize: 25),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          weight: 50.0,
                          Icons.info_outline,
                          color: Color(0xff5428F1),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Ingresa los datos para tu crédito según lo que necesites.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Poppins'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Text(
                          '¿Qué tipo de créditos deseas realizar?',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 14),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<double>(
                      value: cubit.state.tipoPrestamo,
                      onChanged: (newValue) {
                        setState(() {
                          cubit.emit(cubit.state
                              .copyWith(tipoPrestamo: (newValue) ?? 0));
                          //cubit.state.tipoPrestamo = newValue!;
                          print('holaaaa: $newValue');
                          //newValue = discountPercentage;
                          //calculateDiscount();
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 0.3,
                          child: Text('Crédito de vehículo'),
                        ),
                        DropdownMenuItem(
                          value: 0.1,
                          child: Text('Crédito de vivienda'),
                        ),
                        DropdownMenuItem(
                          value: 0.35,
                          child: Text('Crédito de libre inversión'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(
                                  0xffC8D0D9)), // Color del borde cuando está enfocado
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .grey), // Color del borde cuando está habilitado pero no enfocado
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .grey), // Color del borde cuando está deshabilitado
                        ),
                        //labelText: 'Selecciona un descuento',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                    FormTwoItems(
                        title: '¿Cuántos es tu salario base?',
                        titleColor: 0xff0C1022,
                        hasIcon: false,
                        controller: creditController,
                        hintText: '\$10’000.000,00',
                        prefixIcon: '',
                        obscureText: false,
                        onChanged: (value) {
                          cubit.emit(cubit.state
                              .copyWith(salario: double.tryParse(value) ?? 0));
                          cubit.calcularPrestamo();
                        }),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(
                            'Digíta tu salario para calcular el préstamo que necesitas',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                color: Color(0xff525B64)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: Color(0xffC8D0D9)), // Color del borde
                        ),
                        child: Center(
                          child: Text(
                              '\$${cubit.state.montoMaximo.toStringAsFixed(2)}'),
                        )),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '¿A cuántos meses?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: validationMessage
                                    ? Color(0xffC8D0D9)
                                    : Colors.red
                                //Color(0xffC8D0D9)
                                ), // Color del borde
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              enteredNumber = value;
                              cubit.emit(cubit.state.copyWith(
                                  cuotasSeleccionadas: int.parse(value)));
                            },
                            decoration: const InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(color: Color(0xffC8D0D9)),
                              border: InputBorder
                                  .none, // No mostrar el borde por defecto
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12), // Espaciado interno
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Elije un plazo desde 12 hasta 84 meses',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              color: Color(0xff525B64)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    //Text(validationMessage.toString()),
                    ButtonCustom(
                        colorBackground: 0xff5428F1,
                        colorText: 0xffFFFFFF,
                        label: 'Simular',
                        ontap: () {
                          int? numericValue = int.tryParse(enteredNumber);
                          if (numericValue != null &&
                              numericValue >= 12 &&
                              numericValue <= 84) {
                            validationMessage = true;
                            _showModal(context);
                          } else {
                            validationMessage = false;
                          }
                          setState(() {});
                          cubit.calcularPrestamo();
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    loanController.dispose(); // Liberar el controlador
    super.dispose();
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ShowModalBottom();
        });
  }

  void calculateDiscount() {
    discountedPrice = originalPrice * (1 - discountPercentage);
    setState(() {});
  }
}
