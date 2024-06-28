import 'package:bloc_text_form_exam/bloc/email_bloc.dart';
import 'package:bloc_text_form_exam/bloc/name_bloc.dart';
import 'package:bloc_text_form_exam/pages/step_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EmailBloc()),
        BlocProvider(create: (context) => NameBloc()),
      ],
      child: MaterialApp(
        title: 'Bloc Form Validation 예제',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RegistrationPage(),
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StepOne(),
                ),
              );
            },
            child: const Text("Start Registration")),
      ),
    );
  }
}
