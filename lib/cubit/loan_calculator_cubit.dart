import 'dart:math';

import 'package:app_banca/presentation/screens/result_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'loan_calculator_state.dart';

class LoanCalculatorCubit extends Cubit<LoanCalculatorState> {
  LoanCalculatorCubit() : super(LoanCalculatorState.initial());

  void addAmortizationTable(List<TableRow> newTable) {
    final updatedTables = [...state.amortizationTable, newTable];
    emit(state.copyWith(amortizationTable: updatedTables));
  }

  void resetAmortizationTables() {
    emit(state.copyWith(amortizationTable: []));
  }

  void calcularPrestamo() {
    final montoMaximo = (state.salario * 7) / 0.15;
    final cuotasRecomendadas = 7 * 12;
    final tasaInteres = state.tipoPrestamo;
    final valorCuota =
        calcularValorCuota(montoMaximo, tasaInteres, state.cuotasSeleccionadas);
    final intereses = montoMaximo * tasaInteres;

    emit(state.copyWith(
      montoMaximo: montoMaximo,
      cuotasRecomendadas: cuotasRecomendadas,
      tasaInteres: tasaInteres,
      intereses: intereses,
      valorCuota: valorCuota,
    ));
  }

  double calcularValorCuota(
      double montoPrestamo, double tasaInteres, int numeroCuotas) {
    final valorCuota = (montoPrestamo * tasaInteres) /
        (1 - pow(1 + tasaInteres, -numeroCuotas.toDouble()));
    return valorCuota;
  }
}
