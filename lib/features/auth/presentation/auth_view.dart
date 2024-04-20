import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trackify/global/submit_button.dart';


class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: ClipPath(
              //clipper: HeaderWaveClipper(),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xFFD1C4E9),
                    Color(0xFFBBDEFB),
                  ],
                )),
                child: Lottie.asset('assets/animations/login_timer.json'),
              ),
            ),
          ),
          Flexible(
            child: SubmitButton(
              buttonText: 'Login',
              onPressed: () {},
     color: Color(0xFFD1C4E9),
              textColor: Colors.indigo,
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            child: SubmitButton(
              buttonText: 'Sign Up',
              onPressed: (){},
              buttonSize: const Size(300, 50),
              color:  Color(0xFFD1C4E9),
              textColor: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}
