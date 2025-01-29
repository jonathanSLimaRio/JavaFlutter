import 'package:bloodflutter/blocs/donor_bloc.dart';
import 'package:bloodflutter/services/blood_bank_service.dart';
import 'package:bloodflutter/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => DonorBloc(BloodBankService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Bank Analytics',
      theme: ThemeData(
        disabledColor: Colors.grey[400],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}