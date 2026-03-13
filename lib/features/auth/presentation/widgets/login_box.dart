import 'package:chat_app/features/auth/presentation/widgets/auth_input_fields.dart';
import 'package:chat_app/features/auth/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';

class LoginBox extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController pwController;

  const LoginBox({
    super.key,
    required this.emailController,
    required this.pwController,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 500,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login", style: TextStyle(fontSize: 55)),
          Text(
            'Sign in to continue',
            style: TextStyle(color: theme.colorScheme.primary),
          ),
          SizedBox(height: 40),
          //Textfields
          AuthInputFields(
            emailController: emailController,
            passController: pwController,
          ),
          //Login button
          MyButton(buttonName: 'Log in', onTap: () {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                  color: theme.inputDecorationTheme.hintStyle!.color!,
                ),
              ),
              SizedBox(width: 4),
              //Navigate -> Register
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Sign up",
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
