import 'package:chat_app/features/auth/presentation/widgets/auth_input_fields.dart';
import 'package:chat_app/features/auth/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';

class RegisterBox extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController pwController;
  const RegisterBox({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.pwController,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: 550,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Create a new\nAccount",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45,
              height: 1.1,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Sign up to continue',
            style: TextStyle(color: theme.colorScheme.primary),
          ),
          SizedBox(height: 40),
          //Textfields
          AuthInputFields(
            emailController: emailController,
            passController: pwController,
            nameController: nameController,
          ),
          //Login button
          MyButton(buttonName: 'Sign up', onTap: () {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already registered?',
                style: TextStyle(
                  color: theme.inputDecorationTheme.hintStyle!.color,
                ),
              ),
              SizedBox(width: 4),
              //Navigate -> Login
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Log in here',
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
