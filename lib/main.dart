import 'package:app_banca/config/config.dart';
import 'package:app_banca/config/root.dart';
import 'package:app_banca/cubit/loan_calculator_cubit.dart';
import 'package:app_banca/presentation/screens/check_screen.dart';
import 'package:app_banca/presentation/screens/history_screen.dart';
import 'package:app_banca/presentation/screens/home_screen.dart';
import 'package:app_banca/presentation/screens/login.dart';
import 'package:app_banca/presentation/screens/onboarding.dart';
import 'package:app_banca/presentation/screens/result_screen.dart';
import 'package:app_banca/presentation/screens/signup.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<LoanCalculatorCubit>(
            create: (context) => LoanCalculatorCubit())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteList.onBoarding,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => LoanCalculatorCubit(),
        child: RootWidget(
          indexx: 0,
        ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case (RouteList.home):
            return MaterialPageRoute(
                builder: (_) => BlocProvider(
                      create: (context) => LoanCalculatorCubit(),
                      child: HomeScreen(),
                    ));
          case (RouteList.signup):
            return MaterialPageRoute(builder: (_) => SignUp());
          case (RouteList.login):
            return MaterialPageRoute(builder: (_) => Login());
          case (RouteList.check):
            return MaterialPageRoute(builder: (_) => CheckScreen());
          case (RouteList.result):
            return MaterialPageRoute(builder: (_) => ResultScreen());
          case (RouteList.history):
            return MaterialPageRoute(builder: (_) => HistoryScreen());
          case (RouteList.root0):
            return MaterialPageRoute(
                builder: (_) => RootWidget(
                      indexx: 0,
                    ));
          case (RouteList.root1):
            return MaterialPageRoute(
                builder: (_) => RootWidget(
                      indexx: 1,
                    ));
          default:
            return MaterialPageRoute(builder: (_) => OnboardingScreen());
        }
      },
    );
  }
}
