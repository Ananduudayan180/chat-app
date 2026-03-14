import 'package:chat_app/features/auth/presentation/widgets/register_box.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          //Image
          Image.asset(
            'assets/images/registerblackwhite.jpeg',
            fit: BoxFit.cover,
          ),
          //Auth column
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Divider container
              Container(
                width: double.infinity,
                height: 35,
                color: theme.colorScheme.primary,
              ),
              SizedBox(height: 10),
              //Auth Box
              RegisterBox(
                nameController: nameController,
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
