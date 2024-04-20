import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:trackify/global/submit_button.dart';


import '../domain/login_cubit.dart';
import 'common_widgets/form_field_label.dart';
import 'common_widgets/text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500),
        ),
        elevation: 0.8,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFD1C4E9),
            Color(0xFFBBDEFB),
          ])),
        ),
      ),
      body: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Form(
            key: _formKey,
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                final event = state.loginEvent;
                if (event is SuccessfulLoginEvent) {
                  Navigator.of(context).pop();

                } else if (event is FailedLoginEvent) {
                  Navigator.of(context).pop();

                } else if (event is LoadingEvent) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return WillPopScope(
                        onWillPop: () async => false,
                        child: Lottie.asset(
                          'assets/animations/loading_timer.json',
                        ),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormFieldLabel(label: 'Email'),
                    Flexible(
                        child: InputTextField(
                      controller: _emailController,
                    )),
                    const FormFieldLabel(label: 'Password'),
                    Flexible(
                        flex: 1,
                        child: InputTextField(
                          controller: _passwordController,
                          isObscure: true,
                        )),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Center(
                        child: SubmitButton(
                          buttonText: "Login",
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              await _cubit(context).login(_emailController.text,
                                  _passwordController.text);
                            }
                          },
                          textColor: Colors.indigo,
                          buttonSize: const Size(200, 50),
                          color:  Color(0xFFD1C4E9),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  LoginCubit _cubit(context) => BlocProvider.of<LoginCubit>(context);
}
