import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:trackify/features/dashboard/presentation/dashboard_view.dart';
import 'package:trackify/global/submit_button.dart';

import '../../../gen/assets.gen.dart';
import '../../../global/info_snackbar.dart';
import '../domain/login_cubit.dart';
import 'common_widgets/form_field_label.dart';
import 'common_widgets/text_field.dart';

class LoginView extends StatefulWidget {
  static const route = "/login";

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
      resizeToAvoidBottomInset: true,
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
                 context.pop();
                 context.go(DashboardView.route);
                } else if (event is FailedLoginEvent) {
                 context.pop();
                 TopSnackBarOverlay.showTopSnackbar(
                   context: context,
                   message: event.message,
                   backgroundColor: Colors.red,
                   icon: Icons.error,
                 );
                } else if (event is LoadingEvent) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return PopScope(
                          child: Lottie.asset(Assets.animations.loadingTimer));
                    },
                  );
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 24, left: 8, bottom: 16),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24),
                              ),
                            ),
                            const FormFieldLabel(label: 'Email'),
                            InputTextField(
                              controller: _emailController,
                            ),
                            const FormFieldLabel(label: 'Password'),
                            InputTextField(
                              controller: _passwordController,
                              isObscure: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                16.0),
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
                          color: const Color(0xFFD1C4E9),
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
