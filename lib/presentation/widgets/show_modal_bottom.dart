// ignore_for_file: unused_local_variable

import 'package:app_banca/config/config.dart';
import 'package:app_banca/presentation/widgets/button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/loan_calculator_cubit.dart';

class ShowModalBottom extends StatefulWidget {
  const ShowModalBottom({super.key});

  @override
  State<ShowModalBottom> createState() => _ShowModalBottomState();
}

class _ShowModalBottomState extends State<ShowModalBottom> {
  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'es_CO', symbol: '', decimalDigits: 0);
    final cubit = context.read<LoanCalculatorCubit>();
    final interes = cubit.state.tasaInteres * cubit.state.montoMaximo;
    final total = cubit.state.valorCuota - interes;
    final interesPorcentual = (cubit.state.tasaInteres * 10);
    final interesAnual = (interesPorcentual * 12).toStringAsFixed(1);
    String newMontoMAx =
        '\$${currencyFormatter.format(cubit.state.montoMaximo)}';
    String newTotal = '\$${currencyFormatter.format(total)}';
    String newVC = '\$${currencyFormatter.format(cubit.state.valorCuota)}';
    //String newIA = '\$${currencyFormatter.format(interesAnual)}';
    return BlocBuilder<LoanCalculatorCubit, LoanCalculatorState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5, // Initial size of the sheet
          minChildSize: 0.25, // Minimum size the sheet can be dragged to
          maxChildSize: 0.5, // Maximum size the sheet can be dragged to
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 35, left: 25, right: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Cuota máxima de préstamo',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          newVC,
                          //'\$${cubit.state.valorCuota.toStringAsFixed(0)}',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                              fontSize: 30),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            '*Este valor suele cambiar con respecto a tu salario',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5428F1),
                                fontSize: 14,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tasa Efectiva Anual desde',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff525B64),
                                  fontFamily: 'Poppins',
                                  fontSize: 18),
                            ),
                            Text('${interesAnual}%',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tasa Mensual desde',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff525B64),
                                    fontFamily: 'Poppins',
                                    fontSize: 18)),
                            Text('${interesPorcentual.toStringAsFixed(1)}%',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('valor total del prestamo',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff525B64),
                                    fontFamily: 'Poppins',
                                    fontSize: 18)),
                            Text(newMontoMAx,
                                //'${cubit.state.montoMaximo.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))
                          ]),
                    ),
                    Divider(
                      height: 20,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Valor total a pagar',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            Text(newTotal)
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8),
                      child: ButtonCustom(
                          colorBackground: 0xff5428F1,
                          colorText: 0xffFFFFFF,
                          label: 'Continuar',
                          ontap: () {
                            Navigator.pushNamed(context, RouteList.result);
                            setState(() {});
                            cubit.calcularPrestamo();
                          }),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
