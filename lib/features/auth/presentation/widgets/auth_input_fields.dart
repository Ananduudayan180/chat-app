import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:chat_app/features/auth/presentation/utils/form_validator.dart';
import 'package:flutter/material.dart';

class AuthInputFields extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final TextEditingController passController;

  const AuthInputFields({
    super.key,
    this.nameController,
    required this.emailController,
    required this.passController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        child: Column(
          children: [
            nameController != null ? Row(children: [Text("Name")]) : SizedBox(),
            nameController != null
                //Name Textfield
                ? MyTextField(
                    controller: nameController!,
                    hintText: 'Name',
                    validator: FormValidator.name,
                  )
                : SizedBox(),

            Row(children: [Text("Email")]),
            //Email Textfield
            MyTextField(
              controller: emailController,
              hintText: 'Example@gmail.com',
              validator: FormValidator.email,
            ),

            Row(children: [Text("Password")]),
            //Pass Textfield
            MyTextField(
              controller: passController,
              hintText: 'Password',
              obscureText: true,
              validator: FormValidator.pass,
            ),
          ],
        ),
      ),
    );
  }
}
