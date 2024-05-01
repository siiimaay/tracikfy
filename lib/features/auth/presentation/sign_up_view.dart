import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:trackify/features/auth/presentation/login_view.dart';
import 'package:trackify/global/submit_button.dart';

import '../../../core/injection/locator.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/info_snackbar.dart';
import '../domain/sign_up_cubit.dart';
import 'common_widgets/form_field_label.dart';
import 'common_widgets/text_field.dart';

class SignUpView extends StatefulWidget {
  static const route = "/signup";

  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _countryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sign-up",
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
      body: BlocProvider<SignUpCubit>(
        create: (context) => getIt.get<SignUpCubit>(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            final event = state.registerEvent;
            if (event is SuccessfulRegister) {
              context.pop();
              GoRouter.of(context).push(LoginView.route);
            } else if (event is FailedRegister) {
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
                    child: Lottie.asset(Assets.animations.loadingTimer),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Form(
                  key:_formKey ,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 40, left: 8),
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const FormFieldLabel(label: 'Email'),
                          InputTextField(controller: _userNameController),
                          const FormFieldLabel(label: 'Password'),
                          InputTextField(
                            controller: _passwordController,
                            isObscure: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                if (number.isoCode != null) {
                                  _countryController.text = number.isoCode!;
                                }
                              },
                              selectorConfig: const SelectorConfig(
                                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              textFieldController: _phoneNumberController,
                              formatInput: true,
                              keyboardType: const TextInputType.numberWithOptions(
                                signed: true,
                                decimal: true,
                              ),
                              searchBoxDecoration: InputDecoration(
                                hintText: 'Search for country',
                                icon: const Icon(Icons.search),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.indigo,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              inputDecoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.indigo,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom + 16.0),
                    child: SubmitButton(
                      buttonText: 'Create Account',
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          _cubit(context).createAccount(
                            _userNameController.text,
                            _passwordController.text,
                            _phoneNumberController.text,
                            _countryController.text,
                          );
                        }
                      },
                      textColor: Colors.indigo,
                      buttonSize: const Size(200, 45),
                      color: const Color(0xFFD1C4E9),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  SignUpCubit _cubit(context) => BlocProvider.of<SignUpCubit>(context);
}
