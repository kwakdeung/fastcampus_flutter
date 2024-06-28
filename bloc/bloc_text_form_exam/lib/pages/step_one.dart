import 'package:bloc_text_form_exam/bloc/email_bloc.dart';
import 'package:bloc_text_form_exam/pages/step_two.dart';
import 'package:bloc_text_form_exam/regx.dart';
import 'package:bloc_text_form_exam/widgets/flat_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Step 1"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<EmailBloc, EmailState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (email) =>
                        context.read<EmailBloc>().add(EmailChanged(email)),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "이메일",
                      hintText: "이메일을 입력하세요.",
                      border: const OutlineInputBorder(),
                      errorText: !state.isValid ? "유효하지 않은 이메일입니다." : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              BlocBuilder<EmailBloc, EmailState>(
                  buildWhen: (previous, current) =>
                      previous.isValid != current.isValid,
                  builder: (context, state) {
                    return FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StepTwo(),
                          ),
                        );
                      },
                      text: "Next",
                      isActive: state.isValid,
                    );
                  })
            ],
          ),
        ),
      );
}
