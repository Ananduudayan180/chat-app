import 'package:chat_app/features/auth/presentation/widgets/login_box.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          //Image
          Image.asset('assets/images/loginblackwhite.jpeg', fit: BoxFit.cover),
          //Auth column
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Divider container
              Container(
                width: double.infinity,
                height: 35,
                color: theme.primary,
              ),
              SizedBox(height: 10),
              //Auth Box
              LoginBox(
                emailController: emailController,
                pwController: pwController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
