import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/loan_calculator_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LoanCalculatorCubit>();
    final amortizationTable = cubit.state.amortizationTable;
    List<TableRow> rows = [];
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'es_CO', symbol: '', decimalDigits: 0);
    // ignore: unused_local_variable
    String newInteres =
        '\$${currencyFormatter.format(cubit.state.tasaInteres)}';
    // ignore: unused_local_variable
    String newMontoMax =
        '\$${currencyFormatter.format(cubit.state.montoMaximo)}';
    // ignore: unused_local_variable
    String newNoCuotas =
        '${currencyFormatter.format(cubit.state.cuotasSeleccionadas)}';

    rows.add(
      const TableRow(
        decoration: BoxDecoration(color: Colors.white),
        children: [
          TableCell(
              child: Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Monto de crédito',
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
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Fecha',
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
              padding: EdgeInsets.all(5.0),
              child: Text(
                'No. de cuotas',
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
              padding: EdgeInsets.all(5.0),
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
        ],
      ),
    );
    rows.add(
      TableRow(
        children: [
          TableCell(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                newMontoMax,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 9.4,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
          const TableCell(
              child: Center(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'N/a',
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
                newNoCuotas,
                style: const TextStyle(
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
                '${cubit.state.tasaInteres * 10}%',
                //interes.toStringAsFixed(2),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 9.3,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ],
      ),
    );

/*     return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          children: amortizationTable[1],
          border: TableBorder.all(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.grey.shade300,
          ),
        ),
      ),
    ); */
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Historial de créditos',
                  style: TextStyle(
                      height: 2.5,
                      fontFamily: 'Poppins',
                      color: Color(0xff0C1022),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  'Aquí encontrarás tu historial de créditos y el\nregistro de todas tus simulaciones.',
                  style: TextStyle(
                      height: 1.0,
                      fontFamily: 'Poppins',
                      color: Color(0xff0C1022),
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Table(
                children: rows,
                border: TableBorder.all(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.grey.shade300),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: amortizationTable.length,
                itemBuilder: (context, index) {
                  final table = amortizationTable[index];
                  return SingleChildScrollView(
                    child: Table(
                      children: table,
                      border: TableBorder.all(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  weight: 50.0,
                  Icons.info_outline,
                  color: Color(0xffB1B5BB),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'No hay mas datos por mostrar',
                  style: TextStyle(
                      color: Color(0xffB1B5BB),
                      fontFamily: 'Poppins',
                      fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
