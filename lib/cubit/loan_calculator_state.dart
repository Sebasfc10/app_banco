part of 'loan_calculator_cubit.dart';

class LoanCalculatorState extends Equatable {
  final double salario;
  final double montoMaximo;
  final int cuotasRecomendadas;
  final int cuotasSeleccionadas;
  final double tipoPrestamo;
  final double tasaInteres;
  final double intereses;
  final double valorCuota;
  final List<List<TableRow>> amortizationTable;

  LoanCalculatorState(
      {required this.salario,
      required this.montoMaximo,
      required this.cuotasRecomendadas,
      required this.cuotasSeleccionadas,
      required this.tipoPrestamo,
      required this.tasaInteres,
      required this.intereses,
      required this.valorCuota,
      required this.amortizationTable});

  factory LoanCalculatorState.initial() {
    return LoanCalculatorState(
        valorCuota: 0,
        salario: 0,
        montoMaximo: 0,
        cuotasRecomendadas: 12,
        cuotasSeleccionadas: 12,
        tipoPrestamo: 0.1,
        tasaInteres: 0.01,
        intereses: 0,
        amortizationTable: [[]]);
  }

  @override
  List<Object> get props => [
        salario,
        montoMaximo,
        cuotasRecomendadas,
        cuotasSeleccionadas,
        tipoPrestamo,
        tasaInteres,
        intereses,
        valorCuota,
        amortizationTable
      ];

  LoanCalculatorState copyWith(
      {double? salario,
      double? montoMaximo,
      int? cuotasRecomendadas,
      int? cuotasSeleccionadas,
      double? tipoPrestamo,
      double? tasaInteres,
      double? intereses,
      double? valorCuota,
      List<List<TableRow>>? amortizationTable}) {
    return LoanCalculatorState(
      salario: salario ?? this.salario,
      montoMaximo: montoMaximo ?? this.montoMaximo,
      cuotasRecomendadas: cuotasRecomendadas ?? this.cuotasRecomendadas,
      cuotasSeleccionadas: cuotasSeleccionadas ?? this.cuotasSeleccionadas,
      tipoPrestamo: tipoPrestamo ?? this.tipoPrestamo,
      tasaInteres: tasaInteres ?? this.tasaInteres,
      intereses: intereses ?? this.intereses,
      valorCuota: valorCuota ?? this.valorCuota,
      amortizationTable: amortizationTable ?? this.amortizationTable,
    );
  }
}
