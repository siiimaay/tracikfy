import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:trackify/global/submit_button.dart';

import '../../../core/injection/locator.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
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
              // GoRouter.of(context).go('/${AppRouter.loginRoute}');
            } else if (event is FailedRegister) {
              Navigator.of(context).pop();
            } else if (event is LoadingEvent) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return WillPopScope(
                    onWillPop: () async => false,
                    child:
                        Lottie.asset('assets/animations/loading_timer.json'),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                height: 600,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const FormFieldLabel(label: 'Email'),
                      Flexible(
                          child: InputTextField(
                        controller: _userNameController,
                      )),
                      const FormFieldLabel(label: 'Password'),
                      Flexible(
                          child: InputTextField(
                        controller: _passwordController,
                        isObscure: true,
                      )),
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
                      const Spacer(),
                      Center(
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
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SignUpCubit _cubit(context) => BlocProvider.of<SignUpCubit>(context);
}
