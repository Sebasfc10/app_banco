import 'dart:io';

import 'package:app_banca/config/config.dart';
import 'package:app_banca/cubit/loan_calculator_cubit.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/button_custom.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

//METODO AUN NO ESTA TERMINADO
/*   Future<void> exportToExcel(List<LoanCalculatorState> tableData) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    // Add headers
    final headers = [
      'Cuota',
      'Valor Cuota',
      'Saldo Inicial',
      'Interés',
      'Amortización',
    ];
    for (int col = 0; col < headers.length; col++) {
      final cell =
          sheet.cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: col));
      cell.value = headers[col];
    }

    // Add rows
    for (int row = 0; row < tableData.length; row++) {
      final rowCells = [
        tableData[row].cuotasSeleccionadas,
        tableData[row].valorCuota,
        tableData[row].salario,
        tableData[row].intereses,
        tableData[row].amortizationTable,
      ];
      for (int col = 0; col < rowCells.length; col++) {
        final cell = sheet.cell(
            CellIndex.indexByColumnRow(rowIndex: row + 1, columnIndex: col));
        cell.value = rowCells[col];
      }
    }

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/amortization_table.xlsx';
    final file = File(filePath);
   }*/

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoanCalculatorCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
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
      body: BlocBuilder<LoanCalculatorCubit, LoanCalculatorState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0, left: 20, right: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Resultado de tu \nsimulador de crédito',
                        style: TextStyle(
                            height: 1.4,
                            color: Color(0xff5428F1),
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                        'Te presentamos en tu tabla de amortización el resultado del movimiento de tu crédito.',
                        style: TextStyle(
                            height: 1.0,
                            color: Color(0xff0C1022),
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tabla de créditos',
                            style: TextStyle(
                                height: 1.4,
                                color: Color(0xff000000),
                                fontFamily: 'Poppins',
                                fontSize: 19,
                                fontWeight: FontWeight.bold)),
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/logo/tool.png'))
                      ],
                    ),
                  ),
                  AmortizationTable(
                      cubit.state.valorCuota, cubit.state.cuotasSeleccionadas),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ButtonCustom(
                        colorBackground: 0xff5428F1,
                        colorText: 0xffFFFFFF,
                        label: 'Descargar Tabla',
                        ontap: () {}),
                  ),
                  ButtonCustom(
                      colorBackground: 0xffCCD2E4,
                      colorText: 0xff5428F1,
                      label: 'Guardar Tabla',
                      ontap: () {
                        _showModal(context);
                        //Navigator.pushNamed(context, RouteList.history);
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(builder:
              (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  Image.asset('assets/logo/redalert.png'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Está seguro que desea \n Guardar la cotización?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000000),
                          fontSize: 22,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      textAlign: TextAlign.center,
                      'La cotización realizada la podrás consultar en tu historial de créditos.',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color(0xff525B64),
                          fontSize: 14,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  ButtonCustom(
                      colorBackground: 0xff5428F1,
                      colorText: 0xffFFFFFF,
                      label: 'Guardar',
                      ontap: () {
                        Navigator.pushReplacementNamed(
                            context, RouteList.root1);
                      }),
                  ButtonCustom(
                      colorBackground: 0xffFFFFFF,
                      colorText: 0xff5428F1,
                      label: 'Cancelar',
                      ontap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      })
                ],
              ),
            );
          });
        });
  }
}

class AmortizationTable extends StatelessWidget {
  final double valorCuota;
  final int cuotas;

  AmortizationTable(this.valorCuota, this.cuotas);

  @override
  Widget build(BuildContext context) {
    //NumberFormat currencyFormatter = NumberFormat('#,##0', 'es');
    final cubit = context.read<LoanCalculatorCubit>();
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'es_CO', symbol: '', decimalDigits: 0);

    List<TableRow> rows = [];

    // Agrega encabezados de tabla
    rows.add(
      TableRow(
        decoration: BoxDecoration(color: Colors.white),
        children: [
          TableCell(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Cuota',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
          TableCell(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Valor Cuota',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
          TableCell(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Saldo Inicial',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
          TableCell(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Interés',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
          TableCell(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Abono a Capital',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
          TableCell(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Saldo del Periodo',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ],
      ),
    );

    double saldo = cubit.state.montoMaximo;
    double totalIntereses = 0;

    // Genera filas de la tabla
    for (int cuota = 1; cuota <= cuotas; cuota++) {
      double interes = saldo * cubit.state.tasaInteres;
      double amortizacion = valorCuota - interes;
      int vc = valorCuota.toInt();
      double saldoPeriodo = saldo - amortizacion;
      //saldo -= amortizacion;
      totalIntereses += interes;

      //String newInteres = currencyFormatter.format(interes);
      String newInteres = '\$${currencyFormatter.format(interes)}';
      String newValorCuota = '\$${currencyFormatter.format(valorCuota)}';
      String newSaldo = '\$${currencyFormatter.format(saldo)}';
      String newAmortizacion = '\$${currencyFormatter.format(amortizacion)}';
      String newSaldoPeriodo = '\$${currencyFormatter.format(saldoPeriodo)}';

      rows.add(
        TableRow(
          children: [
            TableCell(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  cuota.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 9.4,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
            TableCell(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  newValorCuota,
                  style: TextStyle(
                      color: Color(0xff808A93),
                      fontFamily: 'Poppins',
                      fontSize: 9.4,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
            TableCell(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  newSaldo,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 9.3,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
            TableCell(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  newInteres,
                  //interes.toStringAsFixed(2),
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 9.3,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
            TableCell(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  newAmortizacion,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 9.3,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '+${newSaldoPeriodo}',
                      style: TextStyle(
                          color: Color(0xff2EAE44),
                          fontFamily: 'Poppins',
                          fontSize: 9.3,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
      );
      saldo = saldoPeriodo;
      cubit.resetAmortizationTables();
      cubit.addAmortizationTable([...rows]);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        children: rows,
        border: TableBorder.all(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.grey.shade300),
      ),
    );
  }
}
